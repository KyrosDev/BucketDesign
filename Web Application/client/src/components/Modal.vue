<template>
  <div :class="type + ' modal'">
    <div class="container">
      <span :class="type" v-html="icons[type]"></span>
      <h1 class="title">{{ title }}</h1>
      <p :class="'message ' + type">{{ message }}</p>
      <ul>
        <li v-for="action in actions" :key="action.name">
          <button :class="action.class + ' ' + type" @click="action.callback()">{{ action.name }}</button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "Modal",
  props: {
    type: String,
    message: String,
    title: String,
    actions: Array,
  },
  data: () => {
    return {
      icons: {
        warning: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="140" height="140"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm-1-5h2v2h-2v-2zm0-8h2v6h-2V7z"/></svg>`,
        done: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="140" height="140"><path fill="none" d="M0 0h24v24H0z"/><path d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm-.997-4L6.76 11.757l1.414-1.414 2.829 2.829 5.656-5.657 1.415 1.414L11.003 16z"/></svg>`,
      },
    };
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/utils.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba($color: #000000, $alpha: 0.7);
  z-index: 999;

  .container {
    width: 450px;
    height: 340px;
    background: $white;
    border-radius: 20px;
    position: relative;
    padding: 20px;
    text-align: center;
    span.warning {
      fill: $red;
    }
    span.done {
      fill: $green;
    }
    .title {
      font-size: 2em;
    }
    .message.warning {
      color: $red;
    }
    .message.done {
      color: $green;
    }
    ul {
      width: calc(100% - 40px);
      position: absolute;
      bottom: 20px;
      display: flex;
      flex-direction: row;
      list-style: none;
      padding: 0;
      margin: 0;
      align-items: center;
      justify-content: center;
      li {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        button {
          padding: 12px 24px;
          outline: none;
          border: none;
          border-radius: 5px;
          font-size: 0.8em;
          color: $white;
          cursor: pointer;
          transition: 0.3s;
          box-sizing: border-box;
        }
        .primary.warning {
          background: $red;
          &:hover {
            background: red;
          }
        }
        .secondary.warning {
          border: 2px solid $red;
          color: red;
          background: $white;
          &:hover {
            border: 2px solid red;
          }
        }

        .primary.done {
          background: $green;
        }
        .secondary.done {
          border: 1px solid $green;
          color: $green;
          background: $white;
        }
      }
    }
  }
}
</style>