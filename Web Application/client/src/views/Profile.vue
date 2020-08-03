<template>
  <div v-if="loading" class="loader">
    <div class="line icon1"></div>
    <div class="line icon2"></div>
  </div>
  <div v-else-if="!not_found" class="container">
    <Nav />
    <BottomNav />
    <div class="colored-background"></div>
    <div class="content">
      <div class="header">
        <div class="image-container" :style="'background-image: url(' + profile_picture + ');'"></div>
        <div class="informations">
          <h1 class="username">{{ designer.username }}</h1>
          <h3 class="profession">{{ designer.profession.name }}</h3>
          <p class="biography">{{ designer.biography }}</p>
        </div>
      </div>
      <div class="counters">
        <div class="counter followers">
          <span class="counter_icon">
            <svg xmlns="http://www.w3.org/2000/svg">
              <title>group_icon</title>
              <g id="Layer_2" data-name="Layer 2">
                <g id="Layer_1-2" data-name="Layer 1">
                  <path
                    d="M0,21a8,8,0,0,1,16,0H14A6,6,0,0,0,2,21Zm8-9a6,6,0,1,1,6-6A6,6,0,0,1,8,12Zm0-2A4,4,0,1,0,4,6,4,4,0,0,0,8,10Zm8.28,3.7A8,8,0,0,1,21,21H19a6,6,0,0,0-3.54-5.47l.82-1.83ZM15.6,2.41A5.51,5.51,0,0,1,14,13V11a3.5,3.5,0,0,0,1-6.61Z"
                  />
                </g>
              </g>
            </svg>
          </span>
          <p>{{ designer.edge_followers.counter }} followers.</p>
        </div>
        <div class="counter posts">
          <span class="counter_icon">
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
          <p>{{ designer.edge_posts.counter }} shots.</p>
        </div>
      </div>
      <ul class="posts-container">
        <li
          v-for="post in designer.edge_posts.posts"
          @click="viewDetails(post.shortcode)"
          :key="post._id"
        >
          <div class="image-container" :style="'background-image: url(' + post.previewURL + ');'">
            <div class="hover"></div>
          </div>
        </li>
      </ul>
    </div>
  </div>
  <div v-else-if="not_found">
    <h1>User not found</h1>
  </div>
</template>

<script>
import Nav from "../components/PostNav";
import BottomNav from "../components/bottomBar";
import axios from "axios";

const HOST = "http://localhost:5000";

export default {
  components: {
    Nav,
    BottomNav,
  },
  data: () => {
    return {
      designer: null,
      profile_picture: null,
      not_found: false,
      loading: true,
    };
  },
  mounted() {
    const API_URL = `${HOST}/api/designers/username/${this.$route.params.username}`;
    axios.get(API_URL).then((response) => {
      this.$data.loading = false;
      if (response.data === "User not found") {
        this.$data.not_found = true;
      } else {
        this.$data.designer = response.data;
        this.$data.profile_picture = `${HOST}/public/${this.$data.designer.profile_picture}`;
      }
    });
  },
  methods: {
    viewDetails(shortcode) {
      this.$router.push({ name: "details", params: { shortcode } });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/variabless.scss";
@import "@/assets/scss/utils.scss";

.colored-background {
  height: 100px;
  width: 50%;
  background-color: $main;
}

.loader {
  width: 100vw;
  height: 100vh;
  background-color: $main;
  display: flex;
  justify-content: center;
  align-items: center;
  .line {
    position: absolute;
    height: 100px;
    width: 100px;
    border-radius: 100px;
    background: transparent;
    border: 4px solid $white;
    border-bottom: none;
    animation: loading 3s infinite cubic-bezier(0.075, 0.82, 0.165, 1);
  }
}

.content {
  margin-bottom: 80px;
  .header {
    display: flex;
    flex-direction: row;
    align-items: center;
    .image-container {
      width: 40%;
      padding-top: 40%;
      background: $red;
      border-radius: 0 0 40px 0;
      background-position: center;
      background-size: cover;
    }
    .informations {
      width: 40%;
      margin-left: 30px;
      .username {
        font-size: 1.7em;
        font-weight: bold;
      }
      .profession {
        margin-top: 5px;
        font-size: 1em;
        font-weight: 400;
        color: $main;
      }
      .biography {
        margin-top: 20px;
        font-size: 0.8em;
      }
    }
  }

  .counters {
    margin-top: 20px;
    display: flex;
    flex-direction: row;
    .counter {
      display: flex;
      flex-direction: row;
      color: $main;
      justify-content: center;
      align-items: center;
      margin: 0 10px;
      .counter_icon {
        overflow: hidden;
        height: 20px;
        width: 20px;
        fill: $main;
      }
      p {
        margin-left: 5px;
      }
    }
  }

  .posts-container {
    margin-top: 120px;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    padding: 0;
    list-style: none;
    width: calc(100vw - 5px);
    li {
      cursor: pointer;
      margin-left: 5px;
      margin-bottom: 5px;
      width: calc(100% / 3 - 5px);
      position: relative;
    }
    .hover {
      width: 100%;
      height: 100%;
      background-color: $black;
      border-radius: 5px;
      position: absolute;
      display: flex;
      top: 0;
      left: 0;
      opacity: 0;
      transition: 0.3s;
      color: white;
      align-items: center;
      justify-content: center;
    }
    .image-container {
      width: 100%;
      padding-top: 100%;
      background-position: center;
      background-size: cover;
      border-radius: 5px;
      &:hover {
        .hover {
          opacity: 0.4;
        }
      }
    }
  }
}
</style>