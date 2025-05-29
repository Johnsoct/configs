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

const htmlRules = {
    'attrs-newline': [ 'error', {
        closeStyle: 'newline',
        ifAttrsMoreThan: 1,
    } ],
    'element-newline': [ 'error', {
        inline: [ 'strong', 'span', 'em', 'pre', 'code', 'mark', 'cite', 'i', 'small' ],
    } ],
    'id-naming-convention': 'error',
    'indent': [ 'error', 4 ],
    'lowercase': 'error',
    'max-element-depth': 'off',
    'no-abstract-roles': 'error',
    'no-accesskey-attrs': 'error',
    'no-aria-hidden-body': 'error',
    'no-duplicate-attrs': 'error',
    'no-duplicate-class': 'error',
    'no-duplicate-id': 'error',
    'no-extra-spacing-attrs': 'error',
    'no-extra-spacing-text': 'error',
    'no-heading-inside-button': 'error',
    'no-inline-styles': 'error',
    'no-invalid-role': 'error',
    'no-multiple-empty-lines': 'error',
    'no-multiple-h1': 'error',
    'no-nested-interactive': 'error',
    'no-non-scalable-viewport': 'error',
    'no-obsolete-tags': 'error',
    'no-positive-tabindex': 'error',
    'no-restricted-attr-values': 'off',
    'no-restricted-attrs': 'off',
    'no-script-style-type': 'error',
    'no-skip-heading-levels': 'error',
    'no-target-blank': 'error',
    'no-trailing-spaces': 'error',
    'prefer-https': 'error',
    'quotes': 'error',
    'require-attrs': [ 'error',
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
    'require-button-type': 'off',
    'require-closing-tags': 'error',
    'require-doctype': 'error',
    'require-explicit-size': 'error',
    'require-form-method': 'error',
    'require-frame-title': 'error',
    'require-img-alt': 'error',
    'require-input-label': 'error',
    'require-lang': 'error',
    'require-li-container': 'error',
    'require-meta-charset': 'error',
    'require-meta-description': 'error',
    'require-meta-viewport': 'error',
    'require-open-graph-protocol': 'off',
    'require-title': 'error',
    'sort-attrs': 'error',
    'use-baseline': 'error',
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
    '@stylistic/linebreak-style': [ 'error', 'unix' ],
    '@stylistic/max-len': [
        'warn',
        {
            'code': 120,
            'ignoreStrings': true,
        },
    ],
    '@stylistic/multiline-ternary': [ 'error', 'always' ],
    '@stylistic/object-curly-spacing': [ 'error', 'always' ],
    '@stylistic/semi': [ 'error', 'always' ],
    '@stylistic/space-before-blocks': [ 'error', 'always' ],
    '@stylistic/space-before-function-paren': [ 'error', 'always' ],
    'arrow-body-style': [ 'error', 'always' ],
    'curly': 'error',
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
        environment: 'node',
        fallbackSort: {
            type: 'unsorted',
        },
        groups: [
            [ 'builtin', 'external', 'subpath' ],
            [ 'internal', 'parent', 'sibling' ],
            'type',
            'style',
            [ 'side-effect', 'side-effect-style' ],
        ],
        ignoreCase: true,
        order: 'asc',
        partitionByComment: true,
        specialCharacters: 'keep',
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
    'stylistic/js/indent': 'off',
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
        'baseIndent': 0,
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
            '*.d.ts',
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
        rules: {
            ...vueRules,
            '@typescript-eslint/no-unused-vars': 'off',
            'no-unused-vars': 'off',
            //'vue/script-setup-uses-vars': 'error',
        },
    },
]);

export default [
    globalConfig,
    htmlConfig,
    ...tsConfig,
    ...vueConfig,

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
];


