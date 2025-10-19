import { fileURLToPath } from 'node:url';

import { defineConfig } from 'vitest/config';

// Types
import 'vitest/config';

export default defineConfig({
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
    test: {
        environment: 'jsdom',
        exclude: [
            '**/node_modules/**',
            '**/dist/**',
            '**/.{idea,git,cache,output,temp}/**',
            '**/{karma,rollup,webpack,vite,vitest,jest,ava,babel,nyc,cypress,tsup,build}.config.*',
            'cypress/**',
            'e2e/**',
            'src/components/__tests__/**',
        ],
        expect: {
            requireAssertions: true,
        },
        globals: true,
        include: [
            'vitest/**/*.test.ts',
        ],
        root: fileURLToPath(new URL('./', import.meta.url)),
    },
});
