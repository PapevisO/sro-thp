const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require('tailwindcss/colors')

const toRgba = (hexCode, opacity = 50) => {
    let hex = hexCode.replace('#', '');
    
    if (hex.length === 3) {
        hex = `${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}`;
    }    
    
    const r = parseInt(hex.substring(0, 2), 16);
    const g = parseInt(hex.substring(2, 4), 16);
    const b = parseInt(hex.substring(4, 6), 16);

    return `rgba(${r},${g},${b},${opacity / 100})`;
};

const flattenColorPalette = (obj, sep='-') => Object.assign(
  {}, 
  ...function _flatten(o, p='') { 
    return [].concat(...Object.keys(o)
      .map(k => 
        typeof o[k] === 'object' ?
          _flatten(o[k],k+sep) : 
          ({[p+k]: o[k]})
      )
    );
  }(obj)
);

module.exports = {
  mode: 'jit',
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/components/**/*',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Virgil', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'lime': colors.lime,
      },
    },
    screens: {
      'sm': {'min': '640px', 'max': '767px'},
      'md': {'min': '768px', 'max': '1023px'},
      'lg': {'min': '1024px', 'max': '1279px'},
      'xl': {'min': '1280px', 'max': '1535px'},
      '2xl': {'min': '1536px'},
      '-2xl': {'max': '1535px'},
      '-xl': {'max': '1279px'},
      '-lg': {'max': '1023px'},
      '-md': {'max': '767px'},
      '-sm': {'max': '639px'},
    }
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    function ({ addUtilities, theme }) {
      const utilities = {
        '.bg-stripes': {
          backgroundImage:
            'linear-gradient(-45deg, var(--stripes-color) 12.50%, transparent 12.50%, transparent 40%, var(--stripes-color) 45%, var(--stripes-color) 62.50%, transparent 62.50%, transparent 100%)',
          // backgroundSize: '5.66px 5.66px',
          // backgroundSize: '2.83px 2.83px',
          backgroundSize: '5.66px 5.66px',
        },
      }

      const addColor = (name, color) =>
        (utilities[`.bg-stripes-${name}`] = { '--stripes-color': color })

      const colors = flattenColorPalette(theme('backgroundColor'))
      for (let name in colors) {
        try {
          const [r, g, b, a] = toRgba(colors[name])
          if (a !== undefined) {
            addColor(name, colors[name])
          } else {
            addColor(name, `rgba(${r}, ${g}, ${b}, 0.4)`)
          }
        } catch (_) {
          addColor(name, colors[name])
        }
      }

      addUtilities(utilities)
    },
  ]
}
