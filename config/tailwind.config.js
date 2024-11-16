const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  daisyui: {
      themes: [
        {
          uwu: {
            "primary": "#a6a758",
            "secondary": "#74d8f6",
            "accent": "#4d7fea",
            "base-100": "#ffffdc",
            "neutral": "#909dad",
            "neutral-focus": "#343232",
            "info": "#006ed4",
            "success": "#1ef02e",
            "warning": "#eee953",
            "error": "#d04e41",
            "--rounded-box": "0.75rem",
            "--rounded-btn": ".25rem",
            "--rounded-badge": ".25rem",
            "--animation-btn": "0",
            "--animation-input": "0",
            "--btn-text-case": "normal",
            "--btn-focus-scale": "1",
            "--tab-radius": "0",
          },
        },
      ],
    styled: true,
    base: true,
    utils: true,
    logs: true,
    rtl: false,
    prefix: "",
    darkTheme: "uwu",
  },
  plugins: [
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require("daisyui"),
  ],
}
