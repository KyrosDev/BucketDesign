<template>
  <nav>
    <ul>
      <li>
        <p v-if="username !== ''">Hi, {{ username }}</p>
      </li>
      <li>
        <div
          @click="goProfile"
          class="unselectable"
          :style="'background-image: url(' + profileURL + ');'"
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
      profileURL: null,
      username: "",
    };
  },
  mounted() {
    try {
      const designer = JSON.parse(localStorage.designer);
      this.$data.username = designer.username;
      const profile_picture = designer.profile_picture;
      this.$data.profileURL = profile_picture;
    } catch (error) {}
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
@import "../assets/scss/variabless.scss";
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