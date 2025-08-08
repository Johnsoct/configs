import vue from '@vitejs/plugin-vue';
import { defineConfig } from 'vite';
import vueDevTools from 'vite-plugin-vue-devtools';

import aliases from './aliases';

// https://vite.dev/config/
export default defineConfig({
    build: {
        commonjsOptions: {
            transformMixedEsModules: true,
        },
        emptyOutDir: true,
        outDir: "dist",
        reportCompressedSize: true,
    },

    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern-compiler',
            },
        },
    },

    plugins: [
        vue(),
        vueDevTools(),
    ],

    resolve: {
        alias: aliases,
    },

    root: 'src',

    server: {
        port: 3000,
    },
});
