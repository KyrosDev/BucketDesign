<template>
  <div class="container">
    <ul class="professions">
      <li
        class="card"
        v-for="(profession, index) in professions"
        :key="index"
        @click="selected = profession"
      >
        <input type="radio" :id="profession.name" name="profession" :value="profession" />
        <label :for="profession.name">{{ profession.name }}</label>
      </li>
    </ul>
    <h1>
      Choose your
      <br />profession.
    </h1>
  </div>
</template>

<script>

const API_URL = ``;

export default {
  props: {
    callback: Function
  },
  data() {
    return {
      professions: [
        {
          name: "UI Designer",
          shortcode: "uid"
        },
        {
          name: "UX Designer",
          shortcode: "uxd"
        },
        {
          name: "Grahic Designer",
          shortcode: "gd"
        },
        {
          name: "Anim. Designer",
          shortcode: "agd"
        },
        {
          name: "Product Designer",
          shortcode: "pd"
        },
        {
          name: "Motion Designer",
          shortcode: "md"
        },
        {
          name: "Arc. Designer",
          shortcode: "ad"
        },
        {
          name: "Fashion Designer",
          shortcode: "fd"
        }
      ],
      selected: null
    };
  }
};
</script>

<style lang="scss" scoped>
@import "../../assets/scss/variabless.scss";
@import "../../assets/scss/utils.scss";
@import "../../assets/scss/mainLayout.scss";
@import "../../assets/scss/animations.scss";

.container {
  h1 {
    color: $main;
    text-align: center;
  }

  ul {
    list-style: none;
    padding: 0;
    margin: 0;
    display: grid;
    grid-template-columns: 50% 50%;

    li {
      margin: 10px 0;
    }
  }
}
</style>