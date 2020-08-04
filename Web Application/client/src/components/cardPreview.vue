<template>
  <div class="card">
    <div
      class="image-container unselectable"
      v-on:dblclick="like"
      @click="viewDetails"
      :style="'background-image: url(' + post.previewURL + ')'"
    >
      <span class="type"></span>
    </div>
    <div class="info">
      <h3 v-if="author !== null" class="truncate-text unselectable">
        <span @click="viewProfile(author)">{{ author }}</span>
        - {{ post.title }}
      </h3>
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
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  props: {
    post: Object,
  },
  data: () => {
    return {
      likeCounter: 0,
      liked: false,
      designer: {},
      author: null,
    };
  },
  mounted() {
    try {
      const designer = JSON.parse(localStorage.designer);
      this.designer = designer;
      this.likeCounter = this.$props.post.likes.counter;
      this.$props.post.likes.likes.forEach((item) => {
        if (item.id === this.designer._id) {
          this.liked = true;
        }
      });
      axios.get(`http://localhost:5000/api/designers/${this.$props.post.author.id}`).then((response) => {
        this.$data.author = response.data.username;
      })
    } catch (error) {}
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
        .post(
          `http://localhost:5000/api/posts/actions/${this.$props.post._id}`,
          {
            id: this.designer._id,
            method: "unlike"
          }
        )
        .then((response) => {
          return response;
        });
    },
    addLike() {
      axios
        .post(`http://localhost:5000/api/posts/actions/${this.$props.post._id}`, {
          id: this.designer._id,
          method: "like"
        })
        .then((response) => {
          return response;
        });
    },
    viewDetails() {
      const shortcode = this.$props.post.shortcode;
      this.$router.push(`post/${shortcode}`);
    },
    viewProfile(username) {
      this.$router.push({
        name: "profile",
        params: { username },
      });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variabless.scss";
@import "../assets/scss/utils.scss";

.card {
  width: 100%;
  margin-bottom: 10px;
  .image-container {
    cursor: pointer;
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
  .info {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    h3 {
      cursor: pointer;
      width: 70%;
      font-weight: 400;
      font-size: 1em;
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
}
</style>