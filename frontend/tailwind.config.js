/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "../backend/realestate_backend/templates/**/*.{html,js}",
    "../backend/realestate_backend/core/templates/**/*.{html,js}",
    "../backend/realestate_backend/properties/templates/**/*.{html,js}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}