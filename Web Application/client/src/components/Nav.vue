<template>
  <nav>
    <ul>
      <li>
        <p v-if="username !== ''" @click="goProfile">Hi, {{ username }}</p>
      </li>
      <li>
        <div
          @click="goProfile"
          class="unselectable"
          :style="'background-image: url(' + profile_picture + ');'"
          alt="Profile Picture"
        />
      </li>
    </ul>
  </nav>
</template>

<script>
import axios from "axios";

export default {
  data: () => {
    return {
      profile_picture: null,
      username: "",
    };
  },
  mounted() {
    const profile = JSON.parse(localStorage.designer);
    this.$data.username = profile.username;
    this.$data.profile_picture = profile.profile_picture;
  },
  methods: {
    goProfile() {
      const storage = JSON.parse(localStorage.designer);
      this.$router.push({
        name: "profile",
        params: { username: storage.username },
      });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variables.scss";
@import "../assets/scss/mainLayout.scss";
@import "../assets/scss/utils.scss";

nav {
  background: $main;
  position: fixed;
  width: 100%;
  height: 100px;
  border-radius: 0 0 40px 40px;
  padding: 30px 30px;
  z-index: 9999;
  box-shadow: 10px 0 30px rgba($color: $main, $alpha: 0.5);
  ul {
    display: flex;
    flex-wrap: nowrap;
    padding: 0;
    margin: 0;
    list-style: none;
    justify-content: space-between;
    align-content: center;
    li {
      margin: 0;
      padding: 0;
      color: $white;
      justify-self: center;
      font-weight: 500;
      font-size: 1.2em;
      display: flex;
      p {
        align-self: center;
      }

      div {
        height: 40px;
        width: 40px;
        background-position: center;
        background-size: cover;
        border-radius: 15px;
      }
    }

    li:nth-child(2) {
      justify-content: flex-end;
      justify-self: flex-end;
      justify-items: flex-end;
      align-content: flex-end;
      align-items: flex-end;
      align-self: flex-end;
    }
  }
}
</style>