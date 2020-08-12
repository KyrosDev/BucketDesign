<template>
  <section>
    <div class="top">
      <h1>{{ currentIndex + 1 }} / {{ routes.length }}</h1>
      <h1>Let's customize your profile!</h1>
    </div>
    <div class="content">
      <transition name="fade" v-if="currentIndex !== 2">
        <component
          :is="routes[currentIndex].component"
          v-bind:callback="activeButton"
          v-bind:toggle="disableButton"
        />
      </transition>
      <transition name="fade" v-else>
        <ChooseNameAndBio
          v-if="currentIndex === 2"
          v-bind:callback="activeButton"
          v-bind:toggle="disableButton"
          v-bind:setBio="setBio"
          v-bind:setUsername="setUsername"
        />
      </transition>
    </div>
    <div class="button">
      <div :class="currentIndex > 0 ? 'back active' : 'back'">
        <button @click="decrementIndex">Go Back</button>
      </div>
      <button class="next" @click="incrementIndex">{{ currentIndex == 2 ? 'FINISH' : 'CONTINUE' }}</button>
    </div>
  </section>
</template>

<script>
import axios from "axios";

const API_URL = `https://bucketdesign-server.herokuapp.com/api/v2/designers/put/email/${localStorage.user}/`;

import UploadImage from "../components/customize/uploadImage";
import ChooseProfession from "../components/customize/chooseProfession";
import ChooseNameAndBio from "../components/customize/chooseNameAndBio";

export default {
  data: () => {
    return {
      username: "",
      bio: "",
      currentIndex: 0,
      routes: [
        {
          component: UploadImage,
        },
        {
          component: ChooseProfession,
        },
        {
          component: ChooseNameAndBio,
        },
      ],
    };
  },
  components: {
    UploadImage,
    ChooseProfession,
    ChooseNameAndBio,
  },
  created() {
    if (localStorage.user == null) {
      this.$router.go(0);
    }
  },
  methods: {
    incrementIndex() {
      if (this.currentIndex < 3) {
        this.currentIndex++;
      }
      if (this.currentIndex == 3) {
        axios
          .put(API_URL, {
            username: this.username,
            biography: this.bio,
          })
          .then((response) => {
            console.log(response.data);
            localStorage.designer = JSON.stringify(response.data);
          });
        this.$router.push("/app");
      }
    },
    decrementIndex() {
      if (this.currentIndex > 0) {
        this.currentIndex--;
      }
    },
    setUsername(user) {
      this.username = user;
    },
    setBio(bio) {
      this.bio = bio;
    },
    activeButton() {
      const button = this.$el.querySelector(".button");
      button.classList.add("active");
    },
    disableButton() {
      const button = this.$el.querySelector(".button");
      button.classList.remove("active");
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/animations.scss";
@import "../assets/scss/variabless.scss";
@import "../assets/scss/utils.scss";
@import "../assets/scss/mainLayout.scss";

.fade-enter-active {
  transition: opacity 0.8s;
}
.fade-leave-active {
  opacity: 0;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}

.top {
  background: $main;
  height: 150px;
  width: 100%;
  color: $white;
  border-radius: 0 0 40px 40px;
  display: flex;
  padding: 0;
  margin: 0;
  position: fixed;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  @include shadow();

  h1 {
    padding: 0;
    margin: 0;
  }
}

.content {
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.button {
  transition: 0.3s;
  position: fixed;
  top: calc(100%);
  height: 145px;
  width: 100%;
  button.next {
    width: 100%;
    height: 100px;
    background: $main;
    border: none;
    outline: none;
    color: $white;
    font-size: 1.2em;
    border-radius: 40px 40px 0 0;
    @include shadow();
  }

  .back {
    opacity: 0;
    pointer-events: none;
    width: 100%;
    button {
      outline: none;
      width: 100%;
      text-align: center;
      font-size: 1.2em;
      border: none;
      background: transparent;
      color: $main;
    }
    margin-bottom: 20px;
    transition: 0.3s;
    &.active {
      opacity: 1;
      pointer-events: all;
    }
  }

  &.active {
    top: calc(100% - 145px);
  }
}
</style>