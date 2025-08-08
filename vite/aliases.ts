import { fileURLToPath, URL } from 'node:url';

export default {
    "@": fileURLToPath(new URL("./src", import.meta.url)),
    "@base": fileURLToPath(new URL("./src/components/base", import.meta.url)),
    "@composables": fileURLToPath(new URL("./src/composables", import.meta.url)),
    "@cypress": fileURLToPath(new URL("./cypress", import.meta.url)),
    "@privateStyles": fileURLToPath(new URL("./src/styles/private", import.meta.url)),
    "@styles": fileURLToPath(new URL("./src/styles/public", import.meta.url)),
    "@ts": fileURLToPath(new URL("./types", import.meta.url)),
    "@utility": fileURLToPath(new URL("./src/utility", import.meta.url)),
};
