export default {
    defaultSeverity: "error",
    extends: [
        "stylelint-config-standard",
        "stylelint-config-standard-scss",
        "stylelint-config-html/vue",
        "stylelint-config-standard-vue/scss",
    ],
    fix: true,
    ignoreFiles: [
        "dist/**/*",
        "documentation/**/*",
        "node_modules/**/*",
        "public/**/*",
        "**/index.css",
        "**/normalize.css",
        "**/*.map",
        "**/*.{html,js,json,map,min.css,md,ts}"
    ],
    plugins: [
        "@stylistic/stylelint-plugin",
        "stylelint-order",
    ],
    rules: {
        // @-rules
        // @-rules
        // @-rules

        "at-rule-empty-line-before": [
            "always",
            {
                except: [
                    "blockless-after-same-name-blockless",
                    "first-nested"
                ],
                ignore: [
                    "after-comment"
                ],
                ignoreAtRules: [
                    "else",
                    "mixin"
                ]
            }
        ],
        "rule-empty-line-before": [
            "always",
            {
                except: "first-nested",
                ignore: [
                    "after-comment"
                ]
            }
        ],
        "scss/at-mixin-named-arguments": "always",

        // @media
        // @media
        // @media

        "media-feature-range-notation": "prefix",

        // Braces
        // Braces
        // Braces

        "scss/at-else-closing-brace-newline-after": null,
        "scss/at-if-closing-brace-newline-after": null,
        "scss/at-else-closing-brace-space-after": null,
        "scss/at-if-closing-brace-space-after": null,
        "@stylistic/block-closing-brace-empty-line-before": "never",
        "@stylistic/block-closing-brace-newline-after": "always",
        "@stylistic/block-closing-brace-newline-before": "always",
        "@stylistic/block-opening-brace-newline-after": "always",

        // Colors
        // Colors
        // Colors

        "color-function-notation": "modern",
        "color-hex-length": "long",

        // Comments
        // Comments
        // Comments

        "comment-whitespace-inside": "always",

        // CSS Properties
        // CSS Properties
        // CSS Properties

        "declaration-block-no-redundant-longhand-properties": null,
        "declaration-block-no-shorthand-property-overrides": true,
        "declaration-empty-line-before": [
            "always",
            {
                except: [
                    "after-declaration",
                    "first-nested"
                ],
                ignore: [
                    "after-comment"
                ]
            }
        ],
        "declaration-no-important": true,
        "declaration-property-unit-allowed-list": {
            "font-size": [
                "px",
                "rem",
                "vh",
                "vw"
            ]
        },
        "order/properties-alphabetical-order": true,
        "shorthand-property-no-redundant-values": null,
        "value-keyword-case": "lower",

        // CSS Selectors
        // CSS Selectors
        // CSS Selectors

        "selector-attribute-quotes": "always",
        "selector-class-pattern": null,
        "selector-max-compound-selectors": 3,
        "selector-pseudo-element-colon-notation": "double",
        "selector-type-case": "lower",

        // Custom properties
        // Custom properties
        // Custom properties

        "custom-property-empty-line-before": [
            "always",
            {
                except: [ "after-comment", "after-custom-property", "first-nested" ],
            }
        ],

        // Foonctions
        // Foonctions
        // Foonctions

        "function-name-case": "lower",
        "function-url-quotes": "always",

        // Fonts
        // Fonts
        // Fonts

        "font-family-name-quotes": "always-unless-keyword",
        "font-weight-notation": "numeric",

        // Imports
        // Imports
        // Imports

        "import-notation": "string",

        // Indentation
        // Indentation
        // Indentation

        "@stylistic/indentation": [
            4,
            {
                indentClosingBrace: false
            }
        ],
        "max-nesting-depth": 3,

        // Spaces
        // Spaces
        // Spaces

        "@stylistic/block-opening-brace-space-before": "always",

        // Variables
        // Variables
        // Variables

        "scss/dollar-variable-empty-line-after": [
            "always",
            {
                except: [
                    "before-dollar-variable",
                    "last-nested"
                ]
            }
        ],
        "scss/dollar-variable-first-in-block": [
            true,
            {
                except: [
                    "root"
                ],
                ignore: [
                    "comments",
                    "imports"
                ]
            }
        ],
        "scss/dollar-variable-no-missing-interpolation": true
    },
    overrides: [
        {
            customSyntax: "postcss-html",
            files: [
                "*.vue",
                "**/*.vue"
            ],
            name: "Vue <style lang=\"scss\"> specific rules",
            rules: {
                // CSS Properties
                // CSS Properties
                // CSS Properties

                "declaration-property-value-no-unknown": null,

                // Indentation
                // Indentation
                // Indentation

                "@stylistic/indentation": [
                    4,
                    {
                        baseIndentLevel: 1,
                        indentClosingBrace: false,
                    }
                ],
            }
        }
    ]
}
