import eslint from '@eslint/js'
import globals from 'globals'
import perfectionist from 'eslint-plugin-perfectionist'
import stylistic from '@stylistic/eslint-plugin'
import typescript from 'typescript-eslint'
import vue from 'eslint-plugin-vue'

const jsRules = {
    '@stylistic/array-bracket-spacing': [ 'error', 'always' ],
    '@stylistic/arrow-parens': [ 'error', 'always' ],
    '@stylistic/block-spacing': [ 'error', 'always' ],
    '@stylistic/brace-style': [
        'error',
        'stroustrup',
        {
            'allowSingleLine': false,
        }
    ],
    '@stylistic/comma-dangle': [
        'error',
        {
            'arrays': 'always-multiline',
            'exports': 'always-multiline',
            'functions': 'never',
            'imports': 'always-multiline',
            'objects': 'always-multiline',
        },
    ],
    '@stylistic/eol-last': [ 'error', 'always' ],
    '@stylistic/indent': [
        'error',
        4,
        {
            'ignoreComments': false,
            'MemberExpression': 1,
            'SwitchCase': 1,
        }
    ],
    '@stylistic/keyword-spacing': 'error',
    '@stylistic/linebreak-style': [ 'error', 'unix' ],
    '@stylistic/max-len': [
        'warn',
        {
            'code': 120,
            'ignoreStrings': true,
        }
    ],
    '@stylistic/multiline-ternary': [ 'error', 'always' ],
    '@stylistic/object-curly-spacing': [ 'error', 'always' ],
    '@stylistic/semi': [ 'error', 'never' ],
    '@stylistic/space-before-blocks': [ 'error', 'always' ],
    '@stylistic/space-before-function-paren': [ 'error', 'always' ],
    'perfectionist/sort-array-includes': [ 'error', {
        groups: [
            'spread',
            'literal',
        ],
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-classes': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-decorators': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-exports': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-heritage-clauses': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-imports': [ 'error', {
        environment: 'node',
        fallbackSort: {
            type: 'unsorted',
        },
        groups: [
            [ 'builtin', 'external', 'subpath' ],
            [ 'internal', 'parent', 'siblings' ],
            'type',
            'style',
            [ 'side-effect', 'side-effect-style' ],
        ],
        ignoreCase: true,
        order: 'asc',
        partitionByComment: true,
        specialCharacters: 'keep',
        type: 'alphabetical',
        'newlines-between': 'ignore',
    }],
    'perfectionist/sort-maps': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-named-exports': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-named-imports': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-objects': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-sets': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-switch-case': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-variable-declarations': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'curly': 'error',
    'no-debugger': process.env.NODE_ENV === 'production'
        ? 'warn'
        : 'off',
    'no-param-reassign': 'error',
    'no-return-assign': 'error',
    'no-useless-escape': 'error',
    'prefer-object-spread': 'error',
};
const tsRules = {
    ...jsRules,
    'perfectionist/sort-enums': [ 'error', {
        order: 'asc',
        sortByValue: false,
        type: 'alphabetical',
    }],
    'perfectionist/sort-interfaces': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-intersection-types': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-object-types': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-union-types': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    }],
    'perfectionist/sort-imports': ['error', {
        groups: [
            ['builtin', 'external'],
            ['internal'],
            ['parent', 'siblings', 'side-effect'],
            ['side-effect-style'],
        ],
        'newlines-between': 'ignore',
    }],
}
const vueRules = {
    // Unlike js and tsRules, the only rules here are modifications of the
    // flat/recommended config from eslint-plugin-vue
    'vue/attributes-order': [ 'error', {
        'alphabetical': true,
        'order': [
            // v-slot, slot, #, is, v-is
            [ 'SLOT', 'DEFINITION' ],
            // v-for
            'LIST_RENDERING',
            // v-if, v-else-if, v-else, v-show, v-cloak, v-once, v-pre
            [ 'CONDITIONALS', 'RENDER_MODIFIERS' ],
            // v-custom-directive, v-text, v-html
            [ 'OTHER_DIRECTIVES', 'CONTENT' ],
            // v-model
            'TWO_WAY_BINDING',
            // @, v-on
            'EVENTS',
            // HTML attributes, props, ref, key
            [ 'GLOBAL', 'OTHER_ATTR', 'UNIQUE' ], 
        ],
    }],
    'vue/block-order': [ 'error', {
        'order': [
            'template',
            'script',
            'style[scoped]',
            'style:not([scoped])',
        ],
    }],
    // Works alongside vue/max-attributes-per-line
    'vue/first-attribute-linebreak': [ 'error', {
        'multiline': 'below',
        'singleline': 'below',
    }], 
    'vue/html-indent': [ 'error', 4, {
        'attribute': 1,
        'alignAttributesVertically': true,
        'baseIndent': 1,
    }],
    'vue/html-closing-bracket-newline': [ 'error', {
        'singleline': 'never',
        'multiline': 'always',
        'selfClosingTag': {
            'singleline': 'never',
            'multiline': 'always',
        }
    }],
    'vue/script-indent': [ 'error', 4, {
        'baseIndent': 0,
    }],
    'vue/singleline-html-element-content-newline': 'off',
    'vue/v-bind-style': [ 'shorthand', {
        'sameNameShorthand': 'never',
    }],
    'vue/v-slot-style': [ 'error', {
        'atComponent': 'shorthand',
        'default': 'shorthand',
        'named': 'shorthand',
    }],
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
    ...vue.configs[ 'flat/recommended' ],
    files: [ '**/*.{js,mjs,cjs,ts,vue' ],
    ignores: [
        '**/cypress',
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
        sourceType: 'module',
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
    // Overrides
    {
        files: ["*.vue"],
        rules: {
            "stylistic/js/indent": "off",
        },
    },
];
