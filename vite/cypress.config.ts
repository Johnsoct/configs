import { fileURLToPath } from 'node:url';

import vue from '@vitejs/plugin-vue';
import { defineConfig } from "cypress";

export default defineConfig({
    component: {
        devServer: {
            bundler: "vite",
            framework: "vue",
            viteConfig: {
                optimizeDeps: {
                    // Treat cypress/support/component.ts as an entry
                    entries: [
                        './src/**/*.{vue,js,ts}',
                        './cypress/support/component.ts',
                    ],
                    // Pre-bundle always-used node_modules deps
                    include: [
                        '@fortawesome/vue-fontawesome',
                        '@fortawesome/free-solid-svg-icons',
                    ],
                },

                plugins: [
                    vue(),
                ],

                // WARN: START do not modify
                // WARN: START do not modify
                // WARN: START do not modify
                resolve: {
                    alias: {
                        '@': fileURLToPath(new URL('./src', import.meta.url)),
                        '@base': fileURLToPath(new URL('./src/components/base', import.meta.url)),
                        '@composables': fileURLToPath(new URL('./src/composables', import.meta.url)),
                        '@cypress': fileURLToPath(new URL('./cypress', import.meta.url)),
                        '@privateStyles': fileURLToPath(new URL('./src/styles/private', import.meta.url)),
                        '@styles': fileURLToPath(new URL('./src/styles/public', import.meta.url)),
                        '@ts': fileURLToPath(new URL('./types', import.meta.url)),
                        '@utility': fileURLToPath(new URL('./src/utility', import.meta.url)),
                    },
                },

                server: {
                    port: 3001,
                },
                // WARN: END do not modify
                // WARN: END do not modify
                // WARN: END do not modify
            },
        },
        specPattern: 'cypress/**/*.cy.ts',
        supportFile: 'cypress/support/component.ts',
    },
});
