<template>
  <div class="card">
    <div class="image-container">
      <span class="type"></span>
    </div>
    <div class="info">
      <h3>{{ author }} - {{ title }}</h3>
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
        {{ likes }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    image: String,
    title: String,
    likes: Number,
    type: String,
    author: String
  },
  data: () => {
    return {
      liked: false
    };
  },
  methods: {
    like() {
      if (this.liked) {
        this.$props.likes--;
        this.liked = false;
      } else {
        this.liked = true;
        this.$props.likes++;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variabless.scss";

.card {
  width: 100%;
  margin-bottom: 10px;
  .image-container {
    cursor: pointer;
    width: 100%;
    padding-top: 56.25%;
    position: relative;
    overflow: hidden;
    margin-bottom: 20px;
    border-radius: 10px;
    background: red;
  }
  .info {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    h3 {
      cursor: pointer;
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