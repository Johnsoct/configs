import vue from '@vitejs/plugin-vue';
import { defineConfig } from 'vite';
import vueDevTools from 'vite-plugin-vue-devtools';

import aliases from './aliases';
import pkg from './package.json';

// https://vite.dev/config/
export default defineConfig({
    build: {
        commonjsOptions: {
            transformMixedEsModules: true,
        },
        emptyOutDir: true,
        // ../ required because root is set to "src" since main.ts is in /src
        outDir: "../dist",
        reportCompressedSize: true,
    },

    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern-compiler',
            },
        },
    },

    define: {
        __APP_VERSION__: JSON.stringify(pkg.version),
    },

    plugins: [
        vue({
            template: {
                compilerOptions: {
                    isCustomElement: (tag) => {
                        return [ 'highlightjs' ].includes(tag);
                    },
                },
            },
        }),
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
