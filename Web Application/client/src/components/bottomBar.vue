<template>
  <nav class="bottom-nav">
    <ul>
      <li v-for="route in routes" :key="route.index">
        <span
          @click="setRoute(route)"
          :class="index == route.index ? 'active' : 'unactive'"
          v-html="route.html"
        ></span>
      </li>
      <!-- <li>
        <a @click="index = 1" :class="index == 1 ? 'active' : ''">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20.31 20.31">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M16,14.62l4.28,4.28L18.9,20.31,14.62,16A9,9,0,1,1,16,14.62Zm-2-.74a7,7,0,1,0-.14.14Zm-3.84-8.7a2,2,0,1,0,1.64,3.64,2,2,0,0,0,1-1,4,4,0,1,1-5-2.64A4,4,0,0,1,10.18,5.18Z"
                />
              </g>
            </g>
          </svg>
          <div class="dot"></div>
        </a>
      </li>
      <li>
        <a @click="index = 2" :class="index == 2 ? 'active' : ''">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M5.29,18.82,0,20l1.18-5.29a10,10,0,1,1,4.11,4.11Zm.29-2.11.65.35a8,8,0,1,0-3.29-3.29l.35.65-.66,3ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"
                />
              </g>
            </g>
          </svg>
          <div class="dot"></div>
        </a>
      </li>-->
    </ul>
    <button>
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="45" height="45">
        <path fill="none" d="M0 0h24v24H0z" />
        <path d="M11 11V5h2v6h6v2h-6v6h-2v-6H5v-2z" />
      </svg>
    </button>
  </nav>
</template>

<script>
export default {
  data: () => {
    return {
      index: 0,
      routes: [
        {
          name: "app",
          index: 0,
          html: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 18 19">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M16,17V7.8L9,2.27,2,7.8V17Zm2,1a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V7.31a1,1,0,0,1,.38-.78l8-6.31a1,1,0,0,1,1.24,0l8,6.31a1,1,0,0,1,.38.78ZM4,10H6a3,3,0,0,0,6,0h2A5,5,0,0,1,4,10Z"
                />
              </g>
            </g>
          </svg>
          <div class="dot"></div>`,
        },
        {
          name: "search",
          index: 1,
          html: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20.31 20.31">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M16,14.62l4.28,4.28L18.9,20.31,14.62,16A9,9,0,1,1,16,14.62Zm-2-.74a7,7,0,1,0-.14.14Zm-3.84-8.7a2,2,0,1,0,1.64,3.64,2,2,0,0,0,1-1,4,4,0,1,1-5-2.64A4,4,0,0,1,10.18,5.18Z"
                />
              </g>
            </g>
          </svg>
          <div class="dot"></div>`,
        },
        {
          name: "messages",
          index: 2,
          html: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M5.29,18.82,0,20l1.18-5.29a10,10,0,1,1,4.11,4.11Zm.29-2.11.65.35a8,8,0,1,0-3.29-3.29l.35.65-.66,3ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"
                />
              </g>
            </g>
          </svg>
          <div class="dot"></div>`,
        },
      ],
    };
  },
  methods: {
    setRoute(route) {
      this.$router.push({ name: route.name });
      this.index = route.index;
    },
  },
};
</script>

<style lang="scss">
@import "../assets/scss/variabless.scss";
@import "../assets/scss/animations.scss";
@import "../assets/scss/mainLayout.scss";
@import "../assets/scss/utils.scss";

.bottom-nav {
  width: 100%;
  height: 80px;
  position: fixed;
  bottom: 0;
  background: $white;
  border-radius: 30px 30px 0 0;
  display: flex;
  align-items: center;
  z-index: 9999;

  button {
    border: none;
    outline: none;
    background: $main;
    margin: 0;
    display: flex;
    justify-items: center;
    align-items: center;
    padding: 15px;
    border-radius: 25px;
    margin-bottom: 50px;
    cursor: pointer;
    @include shadow();
    svg {
      fill: $white;
    }
  }

  ul {
    padding: 0;
    margin: 0;
    margin-right: 20px;
    list-style: none;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-around;
    width: 70%;
    li {
      transition: 0.3s cubic-bezier(0.075, 0.82, 0.165, 1);
      display: flex;
      justify-content: center;
      flex-direction: column;
      align-items: center;
      width: 30px;
      height: 30px;
      cursor: pointer;
      span {
        transition: 0.3s cubic-bezier(0.075, 0.82, 0.165, 1);
        height: 100%;
        svg {
          height: 100%;
          fill: $unselectedSvg;
        }
      }
    }
    .active {
      transform: translateY(-5px);
      svg {
        fill: $main;
        margin-bottom: 5px;
      }
      .dot {
        width: 5px;
        height: 5px;
        margin: 0 auto;
        border-radius: 100px;
        background-color: $main;
      }
    }
  }
}
</style>