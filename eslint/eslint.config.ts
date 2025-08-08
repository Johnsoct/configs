import eslint from '@eslint/js';
import html from '@html-eslint/eslint-plugin';
import htmlParser from '@html-eslint/parser';
import stylistic from '@stylistic/eslint-plugin';
import perfectionist from 'eslint-plugin-perfectionist';
import vue from 'eslint-plugin-vue';
import { defineConfig } from 'eslint/config';
import globals from 'globals';
import typescript from 'typescript-eslint';
import vueParser from 'vue-eslint-parser';

import aliases from './aliases';

const htmlRules = {
    '@html-eslint/attrs-newline': [ 'error', {
        closeStyle: 'newline',
        ifAttrsMoreThan: 1,
    } ],
    '@html-eslint/element-newline': [ 'error', {
        inline: [ 'strong', 'span', 'em', 'pre', 'code', 'mark', 'cite', 'i', 'small' ],
    } ],
    '@html-eslint/id-naming-convention': 'error',
    '@html-eslint/indent': [ 'error', 4 ],
    '@html-eslint/lowercase': 'error',
    '@html-eslint/max-element-depth': 'off',
    '@html-eslint/no-abstract-roles': 'error',
    '@html-eslint/no-accesskey-attrs': 'error',
    '@html-eslint/no-aria-hidden-body': 'error',
    '@html-eslint/no-duplicate-attrs': 'error',
    '@html-eslint/no-duplicate-class': 'error',
    '@html-eslint/no-duplicate-id': 'error',
    '@html-eslint/no-extra-spacing-attrs': 'error',
    '@html-eslint/no-extra-spacing-text': 'error',
    '@html-eslint/no-heading-inside-button': 'error',
    '@html-eslint/no-inline-styles': 'error',
    '@html-eslint/no-invalid-role': 'error',
    '@html-eslint/no-multiple-empty-lines': 'error',
    '@html-eslint/no-multiple-h1': 'error',
    '@html-eslint/no-nested-interactive': 'error',
    '@html-eslint/no-non-scalable-viewport': 'error',
    '@html-eslint/no-obsolete-tags': 'error',
    '@html-eslint/no-positive-tabindex': 'error',
    '@html-eslint/no-restricted-attr-values': 'off',
    '@html-eslint/no-restricted-attrs': 'off',
    '@html-eslint/no-script-style-type': 'error',
    '@html-eslint/no-skip-heading-levels': 'error',
    '@html-eslint/no-target-blank': 'error',
    '@html-eslint/no-trailing-spaces': 'error',
    '@html-eslint/prefer-https': 'error',
    '@html-eslint/quotes': 'error',
    '@html-eslint/require-attrs': [ 'error',
        {
            attr: 'alt',
            tag: 'img',
        },
        {
            attr: 'class',
            tag: 'div',
        },
        {
            attr: 'class',
            tag: 'span',
        },
    ],
    '@html-eslint/require-button-type': 'off',
    '@html-eslint/require-closing-tags': 'error',
    '@html-eslint/require-doctype': 'error',
    '@html-eslint/require-explicit-size': 'error',
    '@html-eslint/require-form-method': 'error',
    '@html-eslint/require-frame-title': 'error',
    '@html-eslint/require-img-alt': 'error',
    '@html-eslint/require-input-label': 'error',
    '@html-eslint/require-lang': 'error',
    '@html-eslint/require-li-container': 'error',
    '@html-eslint/require-meta-charset': 'error',
    '@html-eslint/require-meta-description': 'error',
    '@html-eslint/require-meta-viewport': 'error',
    '@html-eslint/require-open-graph-protocol': 'off',
    '@html-eslint/require-title': 'error',
    '@html-eslint/sort-attrs': 'error',
    '@html-eslint/use-baseline': 'error',
};
const jsRules = {
    '@stylistic/array-bracket-spacing': [ 'error', 'always' ],
    '@stylistic/arrow-parens': [ 'error', 'always' ],
    '@stylistic/block-spacing': [ 'error', 'always' ],
    '@stylistic/brace-style': [
        'error',
        'stroustrup',
        {
            'allowSingleLine': false,
        },
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
        },
    ],
    '@stylistic/keyword-spacing': 'error',
    '@stylistic/linebreak-style': [ 'off', 'unix' ],
    '@stylistic/lines-between-class-members': [ 'error', {
        enforce: [
            // Always newline betweeen methods
            {
                blankLine: 'always',
                next: 'method',
                prev: '*',
            },
        ],
    } ],
    '@stylistic/max-len': [
        'off',
        {
            'code': 120,
            'ignoreStrings': true,
        },
    ],
    '@stylistic/multiline-ternary': [ 'error', 'always' ],
    '@stylistic/newline-per-chained-call': [ 'error', { ignoreChainWithDepth: 3 } ],
    '@stylistic/object-curly-spacing': [ 'error', 'always' ],
    '@stylistic/padded-blocks': [ 'error', { blocks: 'never' } ],
    '@stylistic/padding-line-between-statements': [ 'error',
        // Always put a newline before directives
        {
            blankLine: 'always',
            next: 'directive',
            prev: '*',
        },
        // Always put a newline after import statements
        {
            blankLine: 'always',
            next: '*',
            prev: 'import',
        },
        {
            blankLine: 'any',
            next: 'import',
            prev: 'import',
        },
        // Always put a newline between export statements
        {
            blankLine: 'always',
            next: 'export',
            prev: 'block-like',
        },
        // Always put a newline before express statements
        {
            blankLine: 'always',
            next: 'expression',
            prev: [ 'block-like' ],
            // prev: '*',
        },
        // Always put a newline before try...catch statements
        {
            blankLine: 'always',
            next: 'try',
            prev: '*',
        },
        // Always put a newline before class declarations
        {
            blankLine: 'always',
            next: 'class',
            prev: '*',
        },
        // Always put a newline before return after any statement
        {
            blankLine: 'always',
            next: 'return',
            prev: '*',
        },
        // Always put a newline before any statement after sequences of const, let, or var
        {
            blankLine: 'always',
            next: '*',
            prev: [ 'const', 'let', 'var' ],
        },
        {
            blankLine: 'always',
            next: [ 'const', 'let', 'var' ],
            prev: '*',
        },
        {
            blankLine: 'any',
            next: [ 'const', 'let', 'var' ],
            prev: [ 'const', 'let', 'var' ],
        },
        // Always put a newline before block-like statements
        {
            blankLine: 'always',
            next: 'block-like',
            prev: '*',
        },
        // Always put a newline before interfaces, enums, types
        {
            blankLine: "always",
            next: [ "enum", "interface", "type" ],
            prev: "*",
        },
        // Do not put a newline before function overloads
        {
            blankLine: "never",
            next: "function",
            prev: "function-overload",
        },
    ],
    '@stylistic/semi': [ 'error', 'always' ],
    '@stylistic/space-before-blocks': [ 'error', 'always' ],
    '@stylistic/space-before-function-paren': [ 'error', 'always' ],
    'arrow-body-style': [ 'error', 'always' ],
    'curly': 'error',
    'no-multiple-empty-lines': [ 'error', {
        max: 2,
        maxBOF: 0,
        maxEOF: 1,
    } ],
    'no-param-reassign': 'error',
    'no-return-assign': 'error',
    'no-unused-vars': 'error',
    'no-useless-escape': 'error',
    'perfectionist/sort-array-includes': [ 'error', {
        groups: [
            'spread',
            'literal',
        ],
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-classes': [ 'error', {
        groups: [
            'index-signature',
            'property',
            'accessor-property',
            'constructor',
            'static-block',
            'get-method',
            'set-method',
            'method',
        ],
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-decorators': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-exports': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-heritage-clauses': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-imports': [ 'error', {
        customGroups: [
            {
                elementNamePattern: '^@base/.+',
                groupName: 'base-components',
                order: 'asc',
                type: 'alphabetical',
            },
            {
                elementNamePattern: '^@composables/.+',
                groupName: 'composables',
                order: 'asc',
                type: 'alphabetical',
            },
            {
                elementNamePattern: '^@smart/.+',
                groupName: 'smart-components',
                order: 'asc',
                type: 'alphabetical',
            },
            {
                elementNamePattern: '^@styles/.+',
                groupName: 'public-styles',
                order: 'asc',
                type: 'alphabetical',
            },
            {
                elementNamePattern: '^@privateStyles/.+',
                groupName: 'private-styles',
                order: 'asc',
                type: 'alphabetical',
            },
        ],
        environment: 'node',
        fallbackSort: {
            type: 'unsorted',
        },
        groups: [
            'builtin',
            'external',
            [ 'internal', 'parent', 'subpath', 'sibling' ],
            'composables',
            'smart-components',
            'base-components',
            [ 'private-styles', 'public-styles', 'style' ],
            [ 'side-effect', 'side-effect-style' ],
            'type',
        ],
        ignoreCase: true,
        internalPattern: Object.keys(aliases).map((key) => {
            return `^${key}/.+`;
        }),
        order: 'asc',
        partitionByComment: true,
        specialCharacters: 'keep',
        tsconfig: {
            rootDir: ".",
        },
        type: 'alphabetical',
    } ],
    'perfectionist/sort-interfaces': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-maps': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-named-exports': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-named-imports': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-objects': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-sets': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-switch-case': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-variable-declarations': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'prefer-object-spread': 'error',
};
const tsRules = {
    ...jsRules,
    '@typescript-eslint/no-unused-vars': 'error',
    'no-unused-vars': 'off',
    'perfectionist/sort-enums': [ 'error', {
        order: 'asc',
        sortByValue: false,
        type: 'alphabetical',
    } ],
    'perfectionist/sort-interfaces': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-intersection-types': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-object-types': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
    'perfectionist/sort-union-types': [ 'error', {
        order: 'asc',
        type: 'alphabetical',
    } ],
};
const vueRules = {
    '@stylistic/indent': 'off',
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
    } ],
    'vue/block-order': [ 'error', {
        'order': [
            'template',
            'script',
            'style[scoped]',
            'style:not([scoped])',
        ],
    } ],
    // Works alongside vue/max-attributes-per-line
    'vue/first-attribute-linebreak': [ 'error', {
        'multiline': 'below',
        'singleline': 'ignore',
    } ],
    'vue/html-closing-bracket-newline': [ 'error', {
        'multiline': 'always',
        'selfClosingTag': {
            'multiline': 'always',
            'singleline': 'never',
        },
        'singleline': 'never',
    } ],
    'vue/html-indent': [ 'error', 4, {
        'alignAttributesVertically': true,
        'attribute': 1,
        'baseIndent': 1,
    } ],
    'vue/max-attributes-per-line': [ 'error', {
        'multiline': {
            'max': 1,
        },
        'singleline': {
            'max': 1,
        },
    } ],
    'vue/script-indent': [ 'error', 4, {
        'baseIndent': 1,
        'switchCase': 1,
    } ],
    'vue/singleline-html-element-content-newline': 'off',
    'vue/v-bind-style': [ 'error', 'shorthand', {
        'sameNameShorthand': 'never',
    } ],
    'vue/v-slot-style': [ 'error', {
        'atComponent': 'shorthand',
        'default': 'shorthand',
        'named': 'shorthand',
    } ],
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
    linterOptions: {
        noInlineConfig: true,
    },
};
const htmlConfig = {
    ...html.configs[ 'flat/recommended' ],
    files: [ '**/*.html' ],
    languageOptions: {
        parser: htmlParser,
    },
    plugins: {
        '@html-eslint': html,
    },
    rules: {
        // From maintainers: "Must be defined. If not, all recommended rules will be lost"
        ...html.configs["flat/recommended"].rules,
        // Our rules
        ...htmlRules,
    },
};
const tsConfig = defineConfig([
    eslint.configs.recommended,
    typescript.configs.recommended,
    {
        files: [ '**/*.{js,mjs,cjs,ts}' ],
        ignores: [
            '**/*.d.ts',
            '**/coverage',
            '**/dist',
        ],
        plugins: {
            '@stylistic': stylistic,
            perfectionist,
        },
        rules: {
            ...tsRules,
        },
    },
]);
const vueConfig = defineConfig([
    ...vue.configs['flat/recommended'],
    {
        files: [ '**/*.vue' ],
        languageOptions: {
            parser: vueParser,
            parserOptions: {
                parser: typescript.parser,
                sourceType: 'module',
            },
        },
        plugins: {
            '@stylistic': stylistic,
            perfectionist,
        },
        rules: {
            ...tsRules,
            ...vueRules,
            '@typescript-eslint/no-unused-vars': 'off',
            'no-unused-vars': 'off',
            //'vue/script-setup-uses-vars': 'error',
        },
    },
]);

export default [
    globalConfig,
    ...tsConfig,
    ...vueConfig,
    htmlConfig,

    // Overrides
    {
        files: [ '**/stores/*.{js,ts}' ],
        plugins: {
            perfectionist,
        },
        rules: {
            'perfectionist/sort-objects': [ 'error', {
                customGroups: [
                    {
                        elementNamePattern: '^(?:state)$',
                        groupName: 'top',
                        selector: 'method',
                    },
                ],
                groups: [
                    'top',
                    [ 'member', 'unknown' ],
                    'method',
                ],
                order: 'asc',
                type: 'alphabetical',
            } ],
        },
    },
    // Enable inline ESLint config rule for selected file
    {
        files: [
            '**/api/**/query.ts',
            '**/odata/*.{test.ts,ts}',
            '**/sand-box.vue',
            '**/*index.html',
            '**/composables/dynamicInputPropAttrs.ts',
        ],
        linterOptions: {
            noInlineConfig: false,
        },
    },
];

