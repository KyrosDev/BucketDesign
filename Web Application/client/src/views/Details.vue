<template>
  <div class="container">
    <Nav />
    <BottomNav />
    <div class="content" v-if="post">
      <h4 class="author">
        <span @click="viewProfile(designer.username)">{{
          designer.username
        }}</span>
        - {{ post.createdAt | luxon }}
      </h4>
      <h1 class="title">{{ post.title }}</h1>
      <div
        class="image-container unselectable"
        v-on:dblclick="like"
        v-bind:style="
          post !== null ? 'background-image: url(' + post.previewURL + ');' : ''
        "
      >
        <img :src="post.previewURL" alt="" />
      </div>
      <div class="likes unselectable" @click="like">
        <span :class="liked ? 'liked' : ''">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 18.48">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path
                  d="M10,1.53A6,6,0,0,1,18.48,10L10,18.48,1.52,10A6,6,0,0,1,10,1.53Z"
                />
              </g>
            </g>
          </svg>
        </span>
        {{ likeCounter }}
      </div>
      <p class="description">
        <span
          v-html="parseDescription !== null ? parseDescription : null"
        ></span>
      </p>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Nav from "../components/PostNav";
import BottomNav from "../components/bottomBar";

export default {
  data: () => {
    return {
      post: null,
      profession: null,
      parseDescription: null,
      liked: false,
      likeCounter: 0,
      designer: null,
    };
  },
  mounted() {
    this.getPost();
  },
  methods: {
    async getPost() {
      const shortcode = this.$route.params.shortcode;
      const API_URL = `http://localhost:5000/api/posts?shortcode=${shortcode}`;
      const response = await axios.get(API_URL, {
        headers: {
          Authorization: this.$cookies.get("__bucketdesign_access_token"),
        },
      });
      if (!response.data.status_code) {
        this.post = response.data;
        this.getAuthor();
      }
    },
    async getAuthor() {
      const API_URL = `http://localhost:5000/api/designers?id=${this.post.designer._id}`;
      const response = await axios.get(API_URL, {
        headers: {
          Authorization: this.$cookies.get("__bucketdesign_access_token"),
        },
      });
      if (!response.data.status_code) {
        this.designer = response.data;
      }
    },
    like() {
      if (this.liked) {
        if (this.likeCounter <= 0) {
          this.likeCounter = 0;
        }
        this.likeCounter--;
        this.liked = false;
        this.leaveLike();
      } else {
        this.liked = true;
        this.likeCounter++;
        this.addLike();
      }
    },
    leaveLike() {
      axios
        .post(`http://localhost:5000/api/v1/posts/actions/${this.post._id}`, {
          id: this.designer._id,
          method: "unlike",
        })
        .then((response) => {
          return response.data;
        });
    },
    addLike() {
      axios
        .post(`http://localhost:5000/api/v1/posts/actions/${this.post._id}`, {
          id: this.designer._id,
          method: "like",
        })
        .then((response) => {
          return response.data;
        });
    },
    viewProfile(username) {
      this.$router.push({ name: "profile", params: { username } });
    },
  },
  components: {
    Nav,
    BottomNav,
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/variables.scss";
@import "../assets/scss/utils.scss";
@import "../assets/scss/animations.scss";
@import "../assets/scss/mainLayout.scss";

.content {
  padding: 0 20px;
  padding-top: 120px;
  @media screen and (min-width: $tablet) {
    padding: 0 100px;
    padding-top: 160px;
  }
  @media screen and (min-width: $desktop) {
    padding: 0 350px;
    padding-top: 160px;
  }
  @media screen and (min-width: $big-desktop) {
    padding: 0 650px;
    padding-top: 160px;
  }
  .author {
    font-weight: 300;
    font-size: 1em;
    margin-bottom: 10px;
    span {
      cursor: pointer;
    }
  }
  .title {
    font-weight: 400;
    line-height: auto;
    margin-bottom: 10px;
  }

  .image-container {
    margin-top: 10px;
    width: 100%;
    position: relative;
    overflow: hidden;
    margin-bottom: 10px;
    border-radius: 10px;
    background-position: center;
    background-size: cover;
    cursor: pointer;
    background-repeat: no-repeat;
    img {
      width: 100%;
    }
  }

  .likes {
    display: flex;
    cursor: pointer;
    flex-direction: row;
    color: $gray;
    margin: 20px 0;
    span {
      transition: 0.5s;
      width: 20px;
      height: 20px;
      margin-right: 10px;
      fill: $gray;
    }
    .liked {
      fill: $red;
      animation-name: like;
      animation-duration: 1s;
    }

    &:active span {
      animation-name: like;
      animation-duration: 1s;
    }
    &:focus span {
      animation-name: like;
      animation-duration: 1s;
    }
    &:hover span {
      animation-name: like;
      animation-duration: 1s;
      animation-iteration-count: infinite;
    }
  }

  .description {
    font-weight: 300;
    font-size: 1em;
  }
}
</style>