<template>
  <div class="container">
    <Nav />
    <BottomNav />
    <div class="content">
      <h4 class="author" v-if="author !== null">
        <span @click="viewProfile(author)">{{ author }}</span>
        - {{ post.createdAt | luxon }}
      </h4>
      <h1 class="title">{{ post !== null ? post.title : "" }}</h1>
      <div
        class="image-container unselectable"
        v-on:dblclick="like"
        v-bind:style="post !== null ? 'background-image: url(' + post.previewURL + ');' : ''"
      ></div>
      <div class="likes unselectable" @click="like">
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
      <p class="description">
        <span v-html="parseDescription !== null ? parseDescription : null"></span>
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
      designer: {},
      author: null,
    };
  },
  mounted() {
    try {
      const designer = JSON.parse(localStorage.designer);
      this.$data.designer = designer;
      const shortcode = this.$route.params.shortcode;
      const POST_URL = `http://localhost:5000/api/v1/posts/${shortcode}`;
      axios.get(POST_URL).then((response) => {
        if (response.status == 200) {
          this.$data.post = response.data;
          this.$data.likeCounter = this.$data.post.likes.counter;
          this.$data.post.likes.likes.forEach((item) => {
            if (item.id === designer._id) {
              this.$data.liked = true;
            }
          });
          this.$data.parseDescription = this.$data.post.description;
          axios
            .get(
              `http://localhost:5000/api/v1/designers/${this.$data.post.author.id}`
            )
            .then((response) => {
              this.$data.author = response.data.username;
            });
        }
      });
    } catch (e) {}
  },
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
@import "../assets/scss/variabless.scss";
@import "../assets/scss/utils.scss";
@import "../assets/scss/animations.scss";
@import "../assets/scss/mainLayout.scss";

.content {
  padding: 0 20px;
  padding-top: 120px;
  .author {
    font-weight: 300;
    font-size: 1em;
    margin-bottom: 10px;
  }
  .title {
    font-weight: 400;
    line-height: auto;
    margin-bottom: 10px;
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
    cursor: pointer;
    background-repeat: no-repeat;
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