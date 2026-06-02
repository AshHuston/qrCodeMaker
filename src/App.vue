<script setup>
import { ref } from 'vue';

const inputValue = ref('');
const qrRef = ref(null);

function generateQRCode() {
  qrRef.value.value = inputValue.value;
}

async function copyQrCode() {
  const originalCanvas = qrRef.value.shadowRoot?.querySelector('canvas')

  if (!originalCanvas) return

  const canvas = document.createElement('canvas')
  canvas.width = originalCanvas.width
  canvas.height = originalCanvas.height

  const ctx = canvas.getContext('2d')

  // White background
  ctx.fillStyle = '#ffffff'
  ctx.fillRect(0, 0, canvas.width, canvas.height)

  const padding = 20

  canvas.width = originalCanvas.width + padding * 2
  canvas.height = originalCanvas.height + padding * 2

  ctx.fillStyle = '#fff'
  ctx.fillRect(0, 0, canvas.width, canvas.height)

  ctx.drawImage(originalCanvas, padding, padding)

  canvas.toBlob(async (blob) => {
    await navigator.clipboard.write([
      new ClipboardItem({
        'image/png': blob
      })
    ])
  })
}

function downloadQrCode() {
  const originalCanvas = qrRef.value.shadowRoot?.querySelector('canvas')

  if (!originalCanvas) return

  const canvas = document.createElement('canvas')
  canvas.width = originalCanvas.width
  canvas.height = originalCanvas.height

  const ctx = canvas.getContext('2d')

  // White background
  ctx.fillStyle = '#ffffff'
  ctx.fillRect(0, 0, canvas.width, canvas.height)

  const padding = 20

  canvas.width = originalCanvas.width + padding * 2
  canvas.height = originalCanvas.height + padding * 2

  ctx.fillStyle = '#fff'
  ctx.fillRect(0, 0, canvas.width, canvas.height)

  ctx.drawImage(originalCanvas, padding, padding)
  if (canvas) {
    const link = document.createElement('a');
    link.download = 'qr-code.png';
    link.href = canvas.toDataURL();
    link.click();
  }
}
</script>

<template>
  <div class="wa-stack wa-gap-s wa-align-center" style="align-items: center; margin-top: 5rem;">
    <h1>FREE QR code generator!</h1>
    <p>No subscriptions, no tricks, no way to pay me even if you wanted to.</p>
    <p>If you want to see the code to know its safe, it's on <a href="https://github.com/AshHuston/qrCodeMaker" target="_blank">github</a>.</p>
    <wa-input
      :value="inputValue"
      @input="inputValue = $event.target.value"
      placeholder="Enter link here"
    ></wa-input>
    <wa-button @click="generateQRCode">Generate QR Code</wa-button>
    <wa-qr-code 
      ref="qrRef"
      size="200"
      style="
        color: var(--wa-color-indigo-20);
        background-color: var(--wa-color-indigo-90);
        border-radius: var(--wa-border-radius-m);
        padding: 1rem;
      "
    ></wa-qr-code>
    <div class="wa-cluster">
      <wa-button @click="copyQrCode">
        <wa-icon name="copy"></wa-icon>
      </wa-button>
      <wa-button @click="downloadQrCode">
        <wa-icon name="download"></wa-icon>
      </wa-button>
    </div>
  </div>
</template>

<style scoped></style>
