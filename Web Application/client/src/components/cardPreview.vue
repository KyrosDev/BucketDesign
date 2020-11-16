<template>
  <div class="card">
    <div
      class="image-container unselectable"
      @click="viewDetails"
      :style="'background-image: url(' + post.previewURL + ')'"
    >
      <span class="type"></span>
    </div>
    <div class="info">
      <h3 v-if="designer.username !== null" class="truncate-text unselectable">
        <div class="container">
          <div
            @click="viewProfile(designer.username)"
            class="profile_picture"
            :style="'background: url(' + designer.profile_picture + ');'"
          ></div>
          <span @click="viewProfile(designer.username)">{{
            designer.username
          }}</span>
          - {{ post.title }}
        </div>
      </h3>
      <div class="likes unselectable">
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
    </div>
  </div>
</template>

<script>
import axios from "axios";
//v-on:dblclick="like"

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
    this.getAuthor();
  },
  methods: {
    async getAuthor() {
      const API_URL = `http://localhost:5000/api/designers?id=${this.$props.post.designer._id}`;
      const response = await axios.get(API_URL, {
        headers: {
          Authorization: this.$cookies.get("__bucketdesign_access_token"),
        },
      });
      if (response.data.status_code) {
        return;
      }
      this.designer = response.data;
    },
    viewDetails() {
      const shortcode = this.$props.post.shortcode;
      this.$router.push(`p/${shortcode}`);
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
@import "../assets/scss/variables.scss";
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

    .container {
      height: 30px;
      display: flex;
      justify-content: flex-start;
      align-items: center;
      .profile_picture {
        width: 30px;
        height: 30px;
        border-radius: 30px;
        padding: 0;
        margin-right: 10px;
        background-position: center;
        background-size: cover;
      }
    }
  }
}
</style>