<template>
  <div v-if="loading" class="loader">
    <div class="line icon1"></div>
    <div class="line icon2"></div>
  </div>
  <section v-else>
    <div class="wrapper">
      <div class="top">
        <p>Hi, designer!</p>
        <h1>Welcome to BucketDesign.</h1>
      </div>
      <form @submit.prevent="register">
        <div class="form-group">
          <label for="email">Email</label>
          <input
            v-model="user.email"
            type="email"
            name="email"
            id="email"
            required
          />
          <transition name="slide-fade">
            <p v-if="emailError" class="error">{{ emailError }}</p>
          </transition>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input
            v-model="user.password"
            type="password"
            name="password"
            id="password"
            required
          />
          <p
            class="pass-length"
            :class="user.password.length >= 8 ? 'good' : null"
          >
            Length: {{ user.password.length }} / 8
          </p>
          <transition name="slide-fade">
            <p v-if="passwordError" class="error">{{ passwordError }}</p>
          </transition>
        </div>
        <button type="submit" class="button-primary">Register</button>

        <div class="register">
          <p>Already have an account?</p>
          <router-link to="login">Sign in</router-link>
        </div>
      </form>
    </div>
  </section>
</template>

<script>
import axios from "axios";
import Joi from "joi";

const schema = Joi.object().keys({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
});

const REGISTER_URL =
  "https://bucketdesign-server.herokuapp.com/api/v2/auth/signup";

export default {
  data: () => {
    return {
      emailError: "",
      passwordError: "",
      error: "",
      user: {
        email: "",
        password: "",
      },
      loading: false,
    };
  },
  watch: {
    user: {
      handler() {
        this.emailError = "";
      },
      deep: true,
    },
  },
  methods: {
    register() {
      this.emailError = "";
      this.passwordError = "";
      this.loading = true;
      if (this.validUser()) {
        axios
          .post(REGISTER_URL, {
            email: this.$data.user.email,
            password: this.$data.user.password,
          })
          .then(
            (response) => {
              this.$data.loading = false;
              this.$cookies.set(
                "__bucketdesign_access_token",
                response.data.token,
                { expires: "1d" }
              );
              this.$router.push("/login");
            },
            (err) => {
              this.$data.loading = false;
              this.$data.error = err.message;
            }
          );
      }
    },
    validUser() {
      const result = Joi.validate(this.user, schema);
      if (result.error === null) {
        return true;
      }
      if (result.error.message.includes("email")) {
        this.emailError = "Email is invalid. 😭";
      } else {
        this.passwordError = "Password is invalid. 🙈";
      }
      this.$data.loading = false;
      return false;
    },
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/variables.scss";
@import "../assets/scss/animations.scss";

.top {
  background: $main;
  color: $white;
  height: 40vh;
  padding: 60px 30px;
  border-radius: 0 0 40px 40px;
  @include shadow();
  position: relative;
  p {
    font-weight: 300;
    margin-bottom: 10px;
  }
  h1 {
    font-weight: 500;
  }
}

form {
  margin-top: -60px;
  display: flex;
  flex-direction: column;
  width: 100%;
  padding: 0 30px;

  .form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 30px;
    position: relative;
    input {
      width: 100%;
      border: none;
      outline: none;
      height: 40px;
      border-radius: 10px;
      padding: 5px 10px;
      color: $main;
      font-size: 1.1em;

      &:focus {
        border: 2px solid $main;
      }
    }
    label {
      color: $white;
      font-size: 1.4em;
      margin-bottom: 5px;
      font-weight: bold;
    }
    .flat-button {
      margin-left: auto;
      padding: 10px;
      color: $main;
    }
  }

  .form-group:nth-child(2) {
    label {
      color: $main;
    }
  }

  .button-primary {
    color: $white;
    background: $main;
    border: none;
    outline: none;
    padding: 10px 0;
    font-size: 1.2em;
    border-radius: 15px;
    text-transform: uppercase;
    @include shadow();
  }
}
.register {
  margin-top: 30px;
  color: $gray;
  text-align: center;
  font-size: 0.9em;
  a {
    color: $main;
    text-decoration: none;
  }
}

.pass-length {
  color: $gray;
}

.pass-length.good {
  color: $main;
}

.error {
  background: $red;
  color: $white;
  font-weight: 300;
  padding: 10px 20px;
  border-radius: 6px;
  margin: 10px 0 0 0;
}

@media screen and (min-width: $tablet) {
  section {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    .wrapper {
      width: 100%;
      height: 60%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;

      @media screen and (min-width: $desktop) {
        height: 60%;
      }
    }
    .top {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      width: 70%;
      height: 50%;
      border-radius: 40px;
      padding-bottom: -60px;

      @media screen and (min-width: $desktop) {
        width: 600px;
      }
    }
    form {
      width: 60%;

      @media screen and (min-width: $desktop) {
        width: 550px;
      }
    }
  }
}
</style>