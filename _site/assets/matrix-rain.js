(() => {
  "use strict";

  const canvas = document.querySelector("canvas.matrix-bg");
  if (!(canvas instanceof HTMLCanvasElement)) {
    return;
  }

  const context = canvas.getContext("2d");
  if (!context) {
    return;
  }

  const MAX_PIXEL_RATIO = 2;
  const FONT_FAMILY = '"Courier New", Courier, monospace, "Microsoft YaHei", "PingFang SC", sans-serif';
  const HEX_GLYPHS = "0123456789ABCDEF";
  const HAN_GLYPHS = String.fromCodePoint(
    0x7535, 0x8111, 0x7f51, 0x7edc, 0x6570, 0x636e, 0x7cfb, 0x7edf,
    0x7801, 0x673a, 0x82af, 0x7247, 0x7b97, 0x6cd5, 0x865a, 0x62df,
    0x4e91, 0x667a, 0x80fd, 0x6e90,
  );
  const COLORS = ["#00ff41", "#bd00ff", "#00f0ff", "#ff38b6"];
  const STREAM_GROUPS = [
    { count: 34, glyphCount: 52, duration: [64, 90], blur: [3, 5], opacity: [0.2, 0.35], size: [0.6, 0.85] },
    { count: 37, glyphCount: 52, duration: [128, 172], blur: [3, 5], opacity: [0.2, 0.35], size: [0.6, 0.85] },
    { count: 18, glyphCount: 26, duration: [42, 58], blur: [2, 3], opacity: [0.4, 0.5], size: [0.9, 1] },
    { count: 17, glyphCount: 26, duration: [84, 116], blur: [2, 3], opacity: [0.4, 0.5], size: [0.9, 1] },
    { count: 10, glyphCount: 16, duration: [28, 38], blur: [6, 8], opacity: [0.2, 0.3], size: [1.1, 1.3] },
    { count: 10, glyphCount: 16, duration: [56, 72], blur: [6, 8], opacity: [0.2, 0.3], size: [1.1, 1.3] },
  ];

  let randomState = 0x1b873593;
  let viewportWidth = 0;
  let viewportHeight = 0;
  let pixelRatio = 1;
  let rootFontSize = 16;
  let animationFrame = 0;

  function random() {
    randomState += 0x6d2b79f5;
    let value = randomState;
    value = Math.imul(value ^ (value >>> 15), value | 1);
    value ^= value + Math.imul(value ^ (value >>> 7), value | 61);
    return ((value ^ (value >>> 14)) >>> 0) / 4294967296;
  }

  function randomBetween([minimum, maximum]) {
    return minimum + (maximum - minimum) * random();
  }

  function randomInteger([minimum, maximum]) {
    return Math.floor(randomBetween([minimum, maximum + 1]));
  }

  function createGlyphs(length) {
    let glyphs = "";

    for (let index = 0; index < length; index += 1) {
      const alphabet = index % 4 === 3 ? HAN_GLYPHS : HEX_GLYPHS;
      glyphs += alphabet[Math.floor(random() * alphabet.length)];
    }

    return glyphs;
  }

  function createStreams() {
    const streams = [];

    for (const group of STREAM_GROUPS) {
      for (let index = 0; index < group.count; index += 1) {
        streams.push({
          blur: randomInteger(group.blur),
          color: COLORS[Math.floor(random() * COLORS.length)],
          duration: randomBetween(group.duration) * 1000,
          glyphs: createGlyphs(group.glyphCount),
          opacity: randomBetween(group.opacity),
          phase: random(),
          size: randomBetween(group.size),
          x: (index + random()) / group.count,
          texture: null,
          textureHeight: 0,
          textureTop: 0,
          textureWidth: 0,
        });
      }
    }

    return streams;
  }

  const streams = createStreams();
  const motionQuery = window.matchMedia("(prefers-reduced-motion: reduce)");

  function createTexture(stream) {
    const fontSize = Math.max(stream.size * rootFontSize, viewportWidth / 100);
    const lineHeight = fontSize * 1.18;
    const padding = Math.ceil(stream.blur * 3 + 2);
    const textureWidth = Math.ceil(fontSize * 1.25 + padding * 2);
    const textureHeight = Math.ceil(lineHeight * stream.glyphs.length + padding * 2);
    const texture = document.createElement("canvas");

    texture.width = Math.ceil(textureWidth * pixelRatio);
    texture.height = Math.ceil(textureHeight * pixelRatio);

    const textureContext = texture.getContext("2d");
    if (!textureContext) {
      return null;
    }

    textureContext.setTransform(pixelRatio, 0, 0, pixelRatio, 0, 0);
    textureContext.filter = `blur(${stream.blur}px)`;
    textureContext.fillStyle = stream.color;
    textureContext.font = `700 ${fontSize}px ${FONT_FAMILY}`;
    textureContext.globalAlpha = stream.opacity;
    textureContext.textAlign = "center";
    textureContext.textBaseline = "top";

    for (let index = 0; index < stream.glyphs.length; index += 1) {
      textureContext.fillText(stream.glyphs[index], textureWidth / 2, padding + index * lineHeight);
    }

    stream.textureHeight = textureHeight;
    stream.textureTop = padding;
    stream.textureWidth = textureWidth;
    return texture;
  }

  function render(timestamp) {
    context.clearRect(0, 0, viewportWidth, viewportHeight);

    const travelDistance = viewportHeight * 3;
    const staticTop = viewportHeight * 0.2;

    for (const stream of streams) {
      if (!stream.texture) {
        continue;
      }

      const top = motionQuery.matches
        ? staticTop
        : -viewportHeight * 1.5 + ((timestamp / stream.duration + stream.phase) % 1) * travelDistance;

      context.drawImage(
        stream.texture,
        stream.x * viewportWidth - stream.textureWidth / 2,
        top - stream.textureTop,
        stream.textureWidth,
        stream.textureHeight,
      );
    }
  }

  function resize() {
    const bounds = canvas.getBoundingClientRect();
    const nextWidth = Math.max(1, Math.round(bounds.width));
    const nextHeight = Math.max(1, Math.round(bounds.height));
    const nextPixelRatio = Math.min(window.devicePixelRatio || 1, MAX_PIXEL_RATIO);

    if (
      nextWidth === viewportWidth
      && nextHeight === viewportHeight
      && nextPixelRatio === pixelRatio
    ) {
      return;
    }

    viewportWidth = nextWidth;
    viewportHeight = nextHeight;
    pixelRatio = nextPixelRatio;
    rootFontSize = Number.parseFloat(getComputedStyle(document.documentElement).fontSize) || 16;
    canvas.width = Math.ceil(viewportWidth * pixelRatio);
    canvas.height = Math.ceil(viewportHeight * pixelRatio);
    context.setTransform(pixelRatio, 0, 0, pixelRatio, 0, 0);

    for (const stream of streams) {
      stream.texture = createTexture(stream);
    }

    render(performance.now());
  }

  function scheduleFrame() {
    if (animationFrame || document.hidden || motionQuery.matches) {
      return;
    }

    animationFrame = window.requestAnimationFrame((timestamp) => {
      animationFrame = 0;
      render(timestamp);
      scheduleFrame();
    });
  }

  function refreshAnimation() {
    if (animationFrame) {
      window.cancelAnimationFrame(animationFrame);
      animationFrame = 0;
    }

    resize();
    render(performance.now());
    scheduleFrame();
  }

  window.addEventListener("resize", refreshAnimation, { passive: true });
  document.addEventListener("visibilitychange", refreshAnimation);
  motionQuery.addEventListener("change", refreshAnimation);
  window.requestAnimationFrame(refreshAnimation);
})();
