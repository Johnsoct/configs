import { FlatCompat } from '@eslint/eslintrc';
import js from '@eslint/js';
import typescriptPlugin from '@typescript-eslint/eslint-plugin';
import typescriptParser from '@typescript-eslint/parser';
import cypress from 'eslint-plugin-cypress';
import globals from 'globals';
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
    baseDirectory: __dirname,
    recommendedConfig: js.configs.recommended,
});
const cypressConfig = {
    files: [
        'cypress/**/*.{cy,spec}.{ts,jsx,tsx}',
        'cypress/**/*.{js,ts,jsx,tsx}',
        'src/**/*.{cy,spec}.*',
        'examples/lint-examples.unit.spec.js',
    ],
    languageOptions: {
        globals: {
            after: 'readonly',
            afterEach: 'readonly',
            before: 'readonly',
            beforeEach: 'readonly',
            context: 'readonly',
            cy: 'readonly',
            Cypress: 'readonly',
            describe: 'readonly',
            expect: 'readonly',
            it: 'readonly',
        },
        parser: typescriptParser,
        parserOptions: {
            project: 'cypress/tsconfig.json',
        },
    },
    plugins: {
        "@typescript-eslint": typescriptPlugin,
        cypress,
    },
    rules: {
        ...cypress.configs.recommended.rules,
    },
};
const jsRules = {
    '@stylistic/js/array-bracket-spacing': ['warn', 'always'],
    '@stylistic/js/arrow-parens': [2, "as-needed", { "requireForBlockBody": true }],
    '@stylistic/js/block-spacing': ['warn', 'always'],
    '@stylistic/js/brace-style': ['warn', 'stroustrup', { 'allowSingleLine': false }],
    '@stylistic/js/comma-dangle': [
        'error',
        {
            "arrays": "always-multiline",
            "exports": "always-multiline",
            "functions": "never",
            "imports": "always-multiline",
            "objects": "always-multiline",
        },
    ],
    '@stylistic/js/consistent-return': 'off',
    '@stylistic/js/eol-last': ['error', 'always'],
    '@stylistic/js/indent': ['error', 8, { 'ignoreComments': false, 'MemberExpression': 1, 'SwitchCase': 1 }],
    '@stylistic/js/keyword-spacing': 'error',
    '@stylistic/js/linebreak-style': ['error', 'unix'],
    '@stylistic/js/max-len': ['warn', { code: 120, 'ignoreStrings': true }],
    '@stylistic/js/multiline-ternary': ['warn', 'always'],
    '@stylistic/js/no-console': 'off',
    '@stylistic/js/no-debugger': process.env.NODE_ENV === 'production'
        ? 'warn'
        : 'off',
    '@stylistic/js/no-plusplus': 'off',
    '@stylistic/js/no-restricted-globals': 'off',
    '@stylistic/js/object-curly-spacing': ['error', 'always'],
    '@stylistic/js/semi': ['error', 'always'],
    '@stylistic/js/space-before-blocks': ['warn', 'always'],
    '@stylistic/js/space-before-function-paren': ['warn', 'always'],
    'arrow-body-style': ['warn', 'always'],
    'curly': 'error',
    'no-param-reassign': 'error',
    'no-return-assign': ['error', 'except-parens'],
    'no-unused-vars': 'off',
    'no-useless-escape': 'warn',
    'prefer-object-spread': 'error',
};
const globalConfig = {
    ignores: [
        '**/dist/**/*',
        '**/node_modules/**/*',
    ],
    languageOptions: {
        globals: {
            ...globals.browser,
        },
        parserOptions: {
            ecmaVersion: 2022,
            sourceType: 'module',
        },
    },
};
const tsConfig = compat.config({
    extends: [
        'eslint:recommended',
        'plugin:@typescript-eslint/recommended',
        'plugin:perfectionist/recommended-alphabetical',
    ],
    ignorePatterns: [
        "cypress",
        'cypress.config.ts',
        'eslint.config.js',
        'env.d.ts',
        'modules.d.ts',
        'shim-vue.d.ts',
        'toastr.d.ts',
        'vite.config.ts',
    ],
    parser: '@typescript-eslint/parser',
    parserOptions: {
        extraFileExtensions: ['.vue'],
        project: true,
        tsconfigRootDir: __dirname,
    },
    plugins: ['@stylistic/js'],
    rules: {
        ...js.configs.recommended.rules,
        ...jsRules,
        '@typescript-eslint/no-unused-vars': 'off',
        'perfectionist/sort-imports': ['off', {
            groups: [
                ['builtin', 'external'],
                ['internal'],
                ['parent', 'siblings', 'side-effect'],
                ['side-effect-style'],
            ],
            'newlines-between': 'ignore',
        }],
        'perfectionist/sort-vue-attributes': 'off',
    },
});
const vueConfig = compat.config({
    env: {
        es2022: true,
        node: true,
    },
    extends: [
        'plugin:vue/base',
        'plugin:vue/vue3-essential',
        'plugin:vue/vue3-strongly-recommended',
        'plugin:vue/vue3-recommended',
    ],
    parser: "vue-eslint-parser",
    parserOptions: {
        ecmaVersion: 2022,
        parser: "@typescript-eslint/parser",
        sourceType: "module",
    },
    plugins: ['vue'],
    rules: {
        '@stylistic/js/indent': 'off', // Turn off in favor of 'vue/script-indent'
        'vue/attributes-order': 'off',
        'vue/html-indent': ['error', 4, {
            'attribute': 1,
            'alignAttributesVertically': true,
            'baseIndent': 1,
        }],
        'vue/html-closing-bracket-newline': ['error', {
            'singleline': 'never',
            'multiline': 'always',
            "selfClosingTag": {
                "singleline": "never",
                "multiline": "always"
            }
        }],
        'vue/multi-word-component-names': 'off',
        'vue/no-side-effects-in-computed-properties': 'warn',
        'vue/no-v-html': 'warn', // Warn (where we're using it, it is safe)
        'vue/script-indent': ['error', 4, {
            'baseIndent': 0,
        }],
        'vue/singleline-html-element-content-newline': 'off',
        'vue/valid-template-root': 'off',
        'vue/valid-v-for': 'off',
    },
});

export default [
    globalConfig,
    cypressConfig,
    ...tsConfig,
    ...vueConfig,
];
