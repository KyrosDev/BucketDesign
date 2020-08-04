<template>
  <nav>
    <ul>
      <li @click="goBack">
        <span>
          <svg
            width="13"
            height="20"
            viewBox="0 0 13 20"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path d="M11 2L3 10L11 18" stroke="white" stroke-width="3" />
          </svg>
        </span>
      </li>
      <li @click="settings ? logout() : goProfile()">
        <div
          v-if="!settings"
          class="unselectable"
          :style="'background-image: url(' + profileURL + ');'"
        />
        <span v-else  class="logout">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewport="0 0 24 24">
            <path fill="none" d="M0 0h24v24H0z" />
            <path
              d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2a9.985 9.985 0 0 1 8 4h-2.71a8 8 0 1 0 .001 12h2.71A9.985 9.985 0 0 1 12 22zm7-6v-3h-8v-2h8V8l5 4-5 4z"
            />
          </svg>
        </span>
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  data: () => {
    return {
      profileURL: null,
      settings: false,
    };
  },
  mounted() {
    try {
      const designer = JSON.parse(localStorage.designer);
      const profile_picture = `https://bucketdesign.herokuapp.com/public/${designer.profile_picture}`;
      if (this.$router.currentRoute.path.includes(designer.username)) {
        this.$data.settings = true;
      } else {
        this.$data.profileURL = profile_picture;
      }
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    goProfile() {
      const storage = JSON.parse(localStorage.designer);
      this.$router.push({
        name: "profile",
        params: { username: storage.username },
      });
    },
    logout() {
      this.$router.push({ name: "logout" });
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variabless.scss";

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
    align-items: center;
    li {
      cursor: pointer;
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
      span {
        height: 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        fill: $white;
      }
    }

    li:nth-child(2) {
      justify-content: flex-end;
      justify-self: flex-end;
      justify-items: flex-end;
    }
  }
}
</style>