<template>
  <form @submit.prevent>
    <label for="username">Username:</label>
    <input @change="setUsernameC" v-model="username" type="text" name="username" id="username" />
    <label for="bio">Biography:</label>
    <textarea
      @change="setBioC"
      v-model="bio"
      name="bio"
      id="bio"
      cols="35"
      rows="10"
      maxlength="150"
    ></textarea>
    <p
      :class="bio.length <= 100 ? 'green' : bio.length < 150 ? 'yellow' : 'red'"
    >Length: {{ bio.length }}/150</p>
  </form>
</template>

<script>
export default {
  props: {
    callback: Function,
    toggle: Function,
    setUsername: Function,
    setBio: Function,
  },
  data: () => {
    return {
      username: "",
      bio: "",
    };
  },
  methods: {
    setUsernameC() {
      if (this.$data.username.length > 3) {
        this.$props.setUsername(this.username);
        this.$props.callback();
      } else {
        this.$props.toggle();
      }
    },
    setBioC() {
      this.$props.setBio(this.bio);
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/variabless.scss";
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/utils.scss";
@import "@/assets/scss/animations.scss";

form {
  display: flex;
  flex-direction: column;
  align-items: flex-start;

  label {
    margin-top: 30px;
    color: $main;
    font-size: 1.4em;
    margin-bottom: 5px;
    font-weight: bold;
  }

  input,
  textarea {
    width: 100%;
    border: none;
    outline: none;
    border-radius: 10px;
    padding: 20px;
    color: $black;
    font-size: 1.1em;
  }

  p {
    transition: 0.3s;
  }

  p.green {
    color: $green;
  }

  p.yellow {
    color: $yellow;
  }

  p.red {
    color: $red;
  }

  input {
    height: 40px;
  }

  textarea {
    resize: none;
  }
}
</style>