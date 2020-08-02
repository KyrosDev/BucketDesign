<template>
  <div class="container">
    <Nav />
    <div class="colored-background"></div>
    <div v-if="designer === null" class="loader"></div>
    <div v-else class="content">
      <div class="header">
        <div class="image-container" :style="'background-image: url(' + profile_picture + ');'"></div>
        <div class="informations">
          <h1 class="username">{{ designer.username }}</h1>
          <h3 class="profession">{{ designer.profession.name }}</h3>
          <p class="biography">{{ designer.biography }}</p>
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
</template>

<script>
import Nav from "../components/PostNav";
import axios from "axios";

const HOST = "http://localhost:5000";

export default {
  components: {
    Nav,
  },
  data: () => {
    return {
      designer: null,
      profile_picture: null,
    };
  },
  mounted() {
    const API_URL = `${HOST}/api/designers/username/${this.$route.params.username}`;
    axios.get(API_URL).then((response) => {
      this.$data.designer = response.data;
      this.$data.profile_picture = `${HOST}/public/${this.$data.designer.profile_picture}`;
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

.content {
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
    margin-bottom: 120px;
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
      transition: .3s;
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
      &:hover{
        .hover{
          opacity: .4;
        }
      }
    }
  }
}
</style>