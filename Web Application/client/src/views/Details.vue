<template>
  <div class="container">
    <Nav />
    <BottomNav />
    <div class="content">
      <h4
        class="author"
      >{{ post !== null ? post.author : "" }} - {{ profession !== null ? profession : "Designer" }}</h4>
      <h1 class="title">{{ post !== null ? post.title : "" }}</h1>
      <p v-if="post !== null">{{ post.createdAt | luxon }}</p>
      <div
        class="image-container"
        v-bind:style="post !== null ? 'background-image: url(' + post.previewURL + ');' : ''"
      ></div>
      <div class="likes" @click="like">
        <span :class="liked ? 'liked' : ''">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 18.48">
            <g id="Layer_2" data-name="Layer 2">
              <g id="Layer_1-2" data-name="Layer 1">
                <path d="M10,1.53A6,6,0,0,1,18.48,10L10,18.48,1.52,10A6,6,0,0,1,10,1.53Z" />
              </g>
            </g>
          </svg>
        </span>
        {{ likeCounter }}
      </div>
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
      liked: false,
      likeCounter: 0
    };
  },
  mounted() {
    const shortcode = this.$route.params.shortcode;
    const POST_URL = `http://localhost:5000/api/posts/${shortcode}`;
    console.log(shortcode);
    axios.get(POST_URL).then(response => {
      if (response.status == 200) {
        this.post = response.data;
        this.likeCounter = post.likes.counter;
        this.post.likes.likes.forEach(user => {
          if (user.userID === "BucketPorcoddio") {
            this.liked = true;
          }
        });
      }
    });
    if (this.post !== null) {
    }
  },
  watch: {},
  methods: {
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
        .post(`http://localhost:5000/api/posts/unlike/${this.post._id}`, {
          user: { userID: "BucketPorcoddio" }
        })
        .then(response => {
          return response.data;
        });
    },
    addLike() {
      axios
        .post(`http://localhost:5000/api/posts/like/${this.post._id}`, {
          user: { userID: "BucketPorcoddio" }
        })
        .then(response => {
          return response.data;
        });
    }
  },
  components: {
    Nav,
    BottomNav
  }
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/variabless.scss";
@import "../assets/scss/utils.scss";
@import "../assets/scss/animations.scss";
@import "../assets/scss/mainLayout.scss";

.content {
  padding: 0 40px;
  padding-top: 120px;
  .author {
    font-weight: 300;
    font-size: 1em;
  }
  .title {
    font-weight: 400;
  }

  .image-container {
    margin-top: 10px;
    width: 100%;
    padding-top: 56.25%;
    position: relative;
    overflow: hidden;
    margin-bottom: 10px;
    border-radius: 10px;
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
  }

  .likes {
    display: flex;
    cursor: pointer;
    flex-direction: row;
    color: $gray;
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
}
</style>