<template>
  <div class="card" @click="callback">
    <div class="header">
      <div class="icon-container">
        <div class="bg" :style="'background-color: ' + iconColor +';'"></div>
        <span :style="'fill: ' + iconColor + ';'" v-html="icon"></span>
      </div>
      <h1>
        {{ title }}
        <span class="line" :style="'background-color: ' + iconColor +';'"></span>
      </h1>
    </div>
    <p>{{ info }}</p>
  </div>
</template>

<script>
export default {
  props: {
    iconColor: String,
    icon: String,
    title: String,
    info: Number,
    callback: Function,
  },
  name: "DashboardPreviewCard",
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/utils.scss";

.card {
  background: white;
  box-shadow: 0 10px 30px rgba($color: #000000, $alpha: 0.07);
  border-radius: 20px;
  padding: 40px;
  max-height: 200px;
  margin-right: 40px;
  transition: 2s cubic-bezier(0.075, 0.82, 0.165, 1);
  min-width: 340px;
  cursor: pointer;

  &:hover {
    box-shadow: 0 20px 40px rgba($color: #000000, $alpha: 0.2);
    transform: translateY(-20px);
  }

  .header {
    display: flex;
    align-items: center;
    h1 {
      font-size: 1.4em;
      position: relative;
      .line {
        width: 19px;
        height: 3px;
        display: block;
        position: absolute;
        bottom: 0px;
      }
    }
  }

  p {
    font-size: 2em;
    font-weight: bold;
    margin-top: 20px;
  }

  .icon-container {
    margin-right: 20px;
    height: 40px;
    width: 40px;
    overflow: hidden;
    border-radius: 10px;
    position: relative;

    .bg {
      width: 100%;
      height: 100%;
      opacity: 0.2;
    }

    span {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 20px;
      height: 20px;
    }
  }
}
</style>