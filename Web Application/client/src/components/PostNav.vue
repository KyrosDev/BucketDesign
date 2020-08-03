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
      <li @click="goProfile">
        <div
          class="unselectable"
          :style="'background-image: url(' + profileURL + ');'"
        />
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  data: () => {
    return {
      profileURL: null,
    };
  },
  mounted() {
    try {
      const designer = JSON.parse(localStorage.designer);
      const profile_picture = `http://localhost:5000/public/${designer.profile_picture}`;
      this.$data.profileURL = profile_picture;
    } catch (error) {}
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
    align-content: center;
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
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
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