import eslint from '@eslint/js'
import globals from 'globals'
import perfectionist from 'eslint-plugin-perfectionist'
import stylistic from '@stylistic/eslint-plugin'
import typescript from 'typescript-eslint'
import vue from 'eslint-plugin-vue'

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
    '@stylistic/js/eol-last': ['error', 'always'],
    '@stylistic/js/indent': ['error', 4, { 'ignoreComments': false, 'MemberExpression': 1, 'SwitchCase': 1 }],
    '@stylistic/js/keyword-spacing': 'error',
    '@stylistic/js/linebreak-style': ['error', 'unix'],
    '@stylistic/js/max-len': ['warn', { code: 120, 'ignoreStrings': true }],
    '@stylistic/js/multiline-ternary': ['warn', 'always'],
    '@stylistic/js/no-console': 'off',
    '@stylistic/js/no-plusplus': 'off',
    '@stylistic/js/no-restricted-globals': 'off',
    '@stylistic/js/object-curly-spacing': ['error', 'always'],
    '@stylistic/js/semi': ['error', 'always'],
    '@stylistic/js/space-before-blocks': ['warn', 'always'],
    '@stylistic/js/space-before-function-paren': ['warn', 'always'],
    'perfectionist/sort-array-includes': ['error', {
        groups: [
            'spread',
            'literal',
        ],
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-classes': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-decorators': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-exports': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-heritage-clauses': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-imports': ['error', {
        environment: 'node',
        fallbackSort: { type: 'unsorted' },
        groups: [
            ['builtin', 'external', 'subpath'],
            ['internal', 'parent', 'siblings'],
            'type',
            'style',
            ['side-effect', 'side-effect-style'],
        ],
        ignoreCase: true,
        order: "asc",
        partitionByComment: true,
        specialCharacters: 'keep',
        type: "alphabetical", 
        'newlines-between': 'ignore',
    }],
    'perfectionist/sort-maps': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-named-exports': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-named-imports': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-objects': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-sets': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-switch-case': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-vue-attributes': 'off',
    'perfectionist/sort-variable-declarations': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'arrow-body-style': ['warn', 'always'],
    'consistent-return': 'off',
    'curly': 'error',
    'no-debugger': process.env.NODE_ENV === 'production'
        ? 'warn'
        : 'off',
    'no-param-reassign': 'error',
    'no-return-assign': ['error', 'except-parens'],
    'no-unused-vars': 'off',
    'no-useless-escape': 'warn',
    'prefer-object-spread': 'error',
};
const tsRules = {
    ...jsRules,
    '@typescript-eslint/no-unused-vars': 'off',
    'perfectionist/sort-enums': ['error', {
        order: 'asc',
        sortByValue: false,
        type: 'alphabetical',
    }],
    'perfectionist/sort-interfaces': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-intersection-types': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-object-types': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-union-types': ['error', {
        order: 'asc',
        type: 'alphabetical',
    }],
}
const vueRules = {
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
}
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
        parserOptions: {
            parser: typescriptParser,
            project: 'cypress/tsconfig.json',
        },
    },
    plugins: {
        cypress,
    },
    rules: {
        ...cypress.configs.recommended.rules,
    },
};
const globalConfig = {
    ignores: [
        '**/dist/**/*',
        '**/node_modules/**/*',
    ],
    languageOptions: {
        ecmaVersion: 2022,
        globals: {
            ...globals.browser,
        },
        sourceType: 'module',
    },
};
const tsConfig = {
    ...eslint.configs.recommended,
    ...typescript.configs.recommended,
    ...vue.configs['flat/recommended'],
    files: [ "**/*.{js,mjs,cjs,ts,vue" ],
    ignores: [
        "**/cypress",
        '*.d.ts',
        '**/coverage',
        '**/dist',
        '*.config.{js,ts}',
    ],
    languageOptions: {
        ecmaVersion: 2022,
        globals: globals.browser,
        parserOptions: {
            parser: typescript.parser,
        },
        sourceType: "module",
    },
    plugins: {
        perfectionist,
        '@stylistic': stylistic,
    },
    rules: {
        ...tsRules,
        ...vueRules,
    },
};

export default [
    globalConfig,
    tsConfig,
];
