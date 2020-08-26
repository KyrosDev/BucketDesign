<template>
  <div :class="expanded ? 'expanded left-nav' : 'left-nav'">
    <ul>
      <!-- 
      <li
        v-for="item in items"
        :class="currentIndex === item.index ? 'active' : null"
        @click="item.callback()"
        :key="item.name"
      >
        <span class="icon" v-html="item.icon"></span>
        <p>{{ item.name }}</p>
      </li>-->
      <li :class="checkQuery(undefined)" @click="callback(null)">
        <span class="icon">
          <svg xmlns="http://www.w3.org/2000/svg">
            <title>home_smile_icon</title>
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M16,17V7.8L9,2.27,2,7.8V17Zm2,1a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V7.31a1,1,0,0,1,.38-.78l8-6.31a1,1,0,0,1,1.24,0l8,6.31a1,1,0,0,1,.38.78ZM4,10H6a3,3,0,0,0,6,0h2A5,5,0,0,1,4,10Z"
                />
              </g>
            </g>
          </svg>
        </span>
        <p>Home</p>
      </li>
      <li :class="checkQuery('designers')" @click="callback('designers')">
        <span class="icon">
          <svg xmlns="http://www.w3.org/2000/svg">
            <title>user_smile_icon</title>
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M10,20A10,10,0,1,1,20,10,10,10,0,0,1,10,20Zm0-2a8,8,0,1,0-8-8A8,8,0,0,0,10,18ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"
                />
              </g>
            </g>
          </svg>
        </span>
        <p>Designers</p>
      </li>
      <li :class="checkQuery('posts')" @click="callback('posts')">
        <span class="icon">
          <svg xmlns="http://www.w3.org/2000/svg">
            <title>image_icon</title>
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M2,8.1l2-2,5.5,5.5L13,8.1l3,3V2H2Zm0,2.83V16H5.1l3-3L4,8.93ZM7.93,16H16V13.93l-3-3ZM1,0H17a1,1,0,0,1,1,1V17a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V1A1,1,0,0,1,1,0ZM12.5,7A1.5,1.5,0,1,1,14,5.5,1.5,1.5,0,0,1,12.5,7Z"
                />
              </g>
            </g>
          </svg>
        </span>
        <p>Posts</p>
      </li>
      <li :class="checkQuery('messages')" @click="callback('messages')">
        <span class="icon">
          <svg xmlns="http://www.w3.org/2000/svg">
            <title>chat_smile_icon</title>
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M5.29,18.82,0,20l1.18-5.29a10,10,0,1,1,4.11,4.11Zm.29-2.11.65.35a8,8,0,1,0-3.29-3.29l.35.65-.66,3ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"
                />
              </g>
            </g>
          </svg>
        </span>
        <p>Messages</p>
      </li>
      <li :class="checkQuery('emails')" @click="callback('emails')">
        <span class="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20">
            <path fill="none" d="M0 0h24v24H0z" />
            <path
              d="M3 3h18a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm17 4.238l-7.928 7.1L4 7.216V19h16V7.238zM4.511 5l7.55 6.662L19.502 5H4.511z"
            />
          </svg>
        </span>
        <p>Emails</p>
      </li>
      <li :class="checkQuery('helper')" @click="callback('helper')">
        <span class="icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
            <path fill="none" d="M0 0h24v24H0z" />
            <path
              d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm-1-5h2v2h-2v-2zm2-1.645V14h-2v-1.5a1 1 0 0 1 1-1 1.5 1.5 0 1 0-1.471-1.794l-1.962-.393A3.501 3.501 0 1 1 13 13.355z"
            />
          </svg>
        </span>
        <p>Helper</p>
      </li>
      <li @click="expanded = !expanded">
        <span class="icon" :class="expanded ? 'rotated' : ''">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20">
            <path fill="none" d="M0 0h24v24H0z" />
            <path d="M13.172 12l-4.95-4.95 1.414-1.414L16 12l-6.364 6.364-1.414-1.414z" />
          </svg>
        </span>
        <p>Decrease</p>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "DashboardNavbar",
  props: {
    callback: Function,
  },
  data: () => {
    return {
      /* items: [
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg"><title>home_smile_icon</title><g id="Layer_1-2" data-name="Layer 1"><path d="M16,17V7.8L9,2.27,2,7.8V17Zm2,1a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V7.31a1,1,0,0,1,.38-.78l8-6.31a1,1,0,0,1,1.24,0l8,6.31a1,1,0,0,1,.38.78ZM4,10H6a3,3,0,0,0,6,0h2A5,5,0,0,1,4,10Z"/></g></svg>`,
          name: "Home",
          index: 0,
        },
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg"><title>user_smile_icon</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M10,20A10,10,0,1,1,20,10,10,10,0,0,1,10,20Zm0-2a8,8,0,1,0-8-8A8,8,0,0,0,10,18ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"/></g></g></svg>`,
          name: "Designers",
          index: 1,
        },
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg"><title>image_icon</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M2,8.1l2-2,5.5,5.5L13,8.1l3,3V2H2Zm0,2.83V16H5.1l3-3L4,8.93ZM7.93,16H16V13.93l-3-3ZM1,0H17a1,1,0,0,1,1,1V17a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V1A1,1,0,0,1,1,0ZM12.5,7A1.5,1.5,0,1,1,14,5.5,1.5,1.5,0,0,1,12.5,7Z"/></g></g></svg>`,
          name: "Posts",
          index: 2,
        },
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg"><title>chat_smile_icon</title><g id="Layer_2" data-name="Layer 2"><g id="Layer_1-2" data-name="Layer 1"><path d="M5.29,18.82,0,20l1.18-5.29a10,10,0,1,1,4.11,4.11Zm.29-2.11.65.35a8,8,0,1,0-3.29-3.29l.35.65-.66,3ZM5,10H7a3,3,0,0,0,6,0h2A5,5,0,0,1,5,10Z"/></g></g></svg>`,
          name: "Messages",
          index: 3,
        },
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20"><path fill="none" d="M0 0h24v24H0z" /><path d="M3 3h18a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm17 4.238l-7.928 7.1L4 7.216V19h16V7.238zM4.511 5l7.55 6.662L19.502 5H4.511z"/></svg>`,
          name: "Emails",
          index: 4,
        },
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0z" /><path d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm-1-5h2v2h-2v-2zm2-1.645V14h-2v-1.5a1 1 0 0 1 1-1 1.5 1.5 0 1 0-1.471-1.794l-1.962-.393A3.501 3.501 0 1 1 13 13.355z"/></svg>`,
          name: "Help",
          index: 5,
        },
        {
          icon: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20"><path fill="none" d="M0 0h24v24H0z" /><path d="M13.172 12l-4.95-4.95 1.414-1.414L16 12l-6.364 6.364-1.414-1.414z" /></svg>`,
          name: "Decrease",
          index: 6,
        },
      ], */
      expanded: true,
    };
  },
  methods: {
    expand() {
      this.expanded = !this.expanded;
    },
    checkQuery(id) {
      const route = this.$route.query;
      if (route.display === id) {
        return "active";
      }
      if (route.display !== id) {
        return null;
      }
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/utils.scss";

.left-nav {
  width: 80px;
  height: 100vh;
  background: $main;
  border-radius: 0 20px 20px 0;
  box-shadow: 0 10px 60px rgba($color: $main, $alpha: 0.5);
  z-index: 10;
  overflow: hidden;
  transition: 0.3s;

  ul {
    transition: 0.3s;
    padding: 0;
    margin: 0 10px;
    margin-top: 80px;
    list-style: none;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    li {
      height: 60px;
      width: 60px;
      padding: 20px 20px;
      color: rgba($color: $white, $alpha: 0.5);
      cursor: pointer;
      display: flex;
      flex-direction: row;
      transition: 0.3s;
      font-size: 1.3em;
      align-items: center;
      border-radius: 200px;
      p {
        display: none;
      }
      .icon {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-right: 10px;
        width: 20px;
        height: 20px;
        transition: 0.3s;
        fill: rgba($color: $white, $alpha: 0.5);
        svg {
          height: 100%;
        }
      }
      .rotated {
        transform: rotate(180deg);
      }

      &:hover {
        background: rgba($color: $black, $alpha: 0.2);
      }
    }
    .active {
      color: $white;
      .icon {
        fill: $white;
      }
    }
  }
}

.left-nav.expanded {
  width: 200px;
  p {
    display: block;
  }
  ul {
    margin-left: 0;
    margin-right: 0;
    li {
      width: 100%;
      border-radius: 0px;
    }
  }
}
</style>