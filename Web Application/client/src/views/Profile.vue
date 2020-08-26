<template>
  <div v-if="loading" class="loader">
    <div class="line icon1"></div>
    <div class="line icon2"></div>
  </div>
  <div v-else-if="!not_found" class="container">
    <Nav />
    <BottomNav />
    <div class="colored-background"></div>
    <transition name="fade" mode="out-in">
      <div v-if="followersModal && followers !== null" class="followers-modal">
        <div class="header">
          <p class="title">
            Followers
            <span>.</span>
          </p>
          <div @click="closeFollowersModal" class="close">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
              <path fill="none" d="M0 0h24v24H0z" />
              <path d="M11 11V5h2v6h6v2h-6v6h-2v-6H5v-2z" />
            </svg>
          </div>
        </div>
        <div class="search-bar">
          <input
            type="text"
            id="username"
            name="username"
            v-model="findUser"
            @keydown="searchByUsername(findUser)"
            @keyup="searchByUsername(findUser)"
            placeholder="Find user..."
            autocomplete="off"
          />
          <span @click="searchByUsername(findUser)">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20.31 20.31">
              <title>search_eye_icon</title>
              <g id="Layer_2" data-name="Layer 2">
                <g id="Layer_1-2" data-name="Layer 1">
                  <path
                    d="M16,14.62l4.28,4.28L18.9,20.31,14.62,16A9,9,0,1,1,16,14.62Zm-2-.74a7,7,0,1,0-.14.14Zm-3.84-8.7a2,2,0,1,0,1.64,3.64,2,2,0,0,0,1-1,4,4,0,1,1-5-2.64A4,4,0,0,1,10.18,5.18Z"
                  />
                </g>
              </g>
            </svg>
          </span>
        </div>
        <ul v-if="!searched && !userNotFound">
          <li
            v-for="follower in followers"
            :key="follower.id"
            @click="goProfile(follower.username)"
          >
            <div
              class="image-container"
              :style="'background-image: url(' + follower.profile_picture + ');'"
            ></div>
            <div class="informations">
              <p class="username">{{ follower.username }}</p>
              <p class="profession">{{ follower.profession.name }}</p>
            </div>
          </li>
        </ul>
        <ul v-if="searched && !userNotFound">
          <li
            v-for="follower in searchResult"
            :key="follower.id"
            @click="goProfile(follower.username)"
          >
            <div
              class="image-container"
              :style="'background-image: url(' + follower.profile_picture + ');'"
            ></div>
            <div class="informations">
              <p class="username">{{ follower.username }}</p>
              <p class="profession">{{ follower.profession.name }}</p>
            </div>
          </li>
        </ul>
        <div class="not-found" v-if="userNotFound">
          <p>User not found</p>
        </div>
      </div>
    </transition>
    <div class="content">
      <div class="header">
        <div class="image-container" :style="'background-image: url(' + profile_picture + ');'"></div>
        <div class="informations">
          <h1 class="username">{{ designer.username }}</h1>
          <h3 class="profession">{{ designer.profession.name }}</h3>
          <p class="biography">{{ designer.biography }}</p>
        </div>
      </div>
      <div class="counters">
        <div @click="showFollowersModal" class="counter followers">
          <span class="counter_icon">
            <svg xmlns="http://www.w3.org/2000/svg">
              <title>group_icon</title>
              <g id="Layer_2" data-name="Layer 2">
                <g id="Layer_1-2" data-name="Layer 1">
                  <path
                    d="M0,21a8,8,0,0,1,16,0H14A6,6,0,0,0,2,21Zm8-9a6,6,0,1,1,6-6A6,6,0,0,1,8,12Zm0-2A4,4,0,1,0,4,6,4,4,0,0,0,8,10Zm8.28,3.7A8,8,0,0,1,21,21H19a6,6,0,0,0-3.54-5.47l.82-1.83ZM15.6,2.41A5.51,5.51,0,0,1,14,13V11a3.5,3.5,0,0,0,1-6.61Z"
                  />
                </g>
              </g>
            </svg>
          </span>
          <p>{{ designer.edge_followers.counter }} followers.</p>
        </div>
        <div class="counter posts">
          <span class="counter_icon">
            <svg xmlns="http://www.w3.org/2000/svg">
              <title>image_icon</title>
              <g id="Layer_2" data-name="Layer 2">
                <g id="Layer_1-2" data-name="Layer 1">
                  <path
                    d="M2,8.1l2-2,5.5,5.5L13,8.1l3,3V2H2Zm0,2.83V16H5.1l3-3L4,8.93ZM7.93,16H16V13.93l-3-3ZM1,0H17a1,1,0,0,1,1,1V17a1,1,0,0,1-1,1H1a1,1,0,0,1-1-1V1A1,1,0,0,1,1,0ZM12.5,7A1.5,1.5,0,1,1,14,5.5,1.5,1.5,0,0,1,12.5,7Z"
                  />
                </g>
              </g>
            </svg>
          </span>
          <p>{{ designer.edge_posts.counter }} shots.</p>
        </div>
      </div>
      <div
        v-if="follow"
        @click="followUser"
        :class="following ? 'follow following' : 'follow unfollowing'"
      >
        <p>{{ following ? 'Following' : 'Follow' }}</p>
      </div>
      <div class="posts">
        <h1 class="title">
          Posts
          <span>.</span>
        </h1>
        <ul class="posts-container">
          <li v-for="post in posts" @click="viewDetails(post.shortcode)" :key="post._id">
            <div class="image-container" :style="'background-image: url(' + post.previewURL + ');'">
              <div class="hover">
                <span>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 18.48">
                    <title>heart_fill_icon</title>
                    <g id="Layer_2" data-name="Layer 2">
                      <g id="Layer_1-2" data-name="Layer 1">
                        <path d="M10,1.53A6,6,0,0,1,18.48,10L10,18.48,1.52,10A6,6,0,0,1,10,1.53Z" />
                      </g>
                    </g>
                  </svg>
                </span>
                <p>{{ post.likes.counter }}</p>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
    <div
      v-if="followersModal && followers !== null"
      @click="closeFollowersModal"
      class="out-clicker"
    ></div>
  </div>
  <div v-else-if="not_found">
    <h1>User not found</h1>
  </div>
</template>

<script>
import Nav from "../components/PostNav";
import BottomNav from "../components/bottomBar";
import axios from "axios";

const HOST = "https://bucketdesign-server.herokuapp.com";

export default {
  components: {
    Nav,
    BottomNav,
  },
  data: () => {
    return {
      designer: null,
      profile_picture: null,
      not_found: false,
      loading: true,
      follow: true,
      following: false,
      followersModal: false,
      designerFollowers: null,
      followers: [],
      posts: [],
      findUser: "",
      searchResult: [],
      searched: false,
      userNotFound: false,
    };
  },
  mounted() {
    try {
      const designer = JSON.parse(localStorage.designer);
      const API_URL = `${HOST}/api/v2/designers/get/username/${this.$route.params.username}`;
      axios.get(API_URL).then((response) => {
        this.$data.loading = false;
        if (response.data === "User not found") {
          this.$data.not_found = true;
        } else {
          this.$data.designer = response.data;
          this.$data.profile_picture = this.$data.designer.profile_picture;

          this.$data.designerFollowers = this.$data.designer.edge_followers.followers;
          this.$data.designerFollowers.map((follower) => {
            axios
              .get(`${HOST}/api/v2/designers/${follower.id}`)
              .then((response) => {
                this.$data.followers.push(response.data);
              });
          });
          this.$data.designer.edge_followers.followers.map((user) => {
            if (user.id == designer._id) {
              this.$data.following = true;
            }
          });
          this.$data.designer.edge_posts.posts.map((post) => {
            axios
              .get(
                `https://bucketdesign-server.herokuapp.com/api/v2/posts/id/${post.id}`
              )
              .then((response) => {
                this.$data.posts.push(response.data);
              });
          });
        }
      });
      if (this.$router.currentRoute.path.includes(designer.username)) {
        this.$data.follow = false;
      }
    } catch (e) {}
  },
  methods: {
    viewDetails(shortcode) {
      this.$router.push({ name: "details", params: { shortcode } });
    },
    followUser() {
      const username = this.$router.currentRoute.path.split("/")[2];
      this.$data.following = !this.$data.following;
      const API_URL = `${HOST}/api/v2/designers/profile/follow/`;
      const designer = JSON.parse(localStorage.designer);
      if (this.$data.following) {
        this.$data.designer.edge_followers.counter++;

        this.$data.followers.push({
          id: designer._id,
          username: designer.username,
          profession: designer.profession,
          profile_picture: `https://bucketdesign-server.herokuapp.com/public/${designer.profile_picture}`,
        });
      } else {
        const designer = JSON.parse(localStorage.designer);
        this.$data.designer.edge_followers.counter--;
        const list = this.$data.followers;
        const index = list.indexOf(designer._id);
        list.splice(index, 1);
      }
      axios
        .post(API_URL, {
          from: designer._id,
          to: username,
          method: this.$data.following ? "follow" : "unfollow",
        })
        .then((response) => {
          localStorage.designer = JSON.stringify(response.data);
        });
    },
    closeFollowersModal() {
      this.$data.followersModal = false;
    },
    showFollowersModal() {
      this.$data.followersModal = true;
    },
    goProfile(username) {
      this.$router.push({ name: "profile", params: { username } });
    },
    searchByUsername(username) {
      const designer = JSON.parse(localStorage.designer);
      if (username !== "") {
        axios
          .get(`${HOST}/api/v2/designers/find/${username}`)
          .then((response) => {
            this.$data.searchResult = [];
            if (response.data == "Not found") {
              this.$data.userNotFound = true;
            } else {
              response.data.map((user) => {
                if (user.username !== designer.username) {
                  this.$data.searchResult.push(user);
                }
              });
              this.$data.userNotFound = false;
              this.$data.searched = true;
            }
          });
      } else {
        this.$data.searched = false;
        this.$data.userNotFound = false;
      }
    },
  },
};
</script>

<style lang="scss" scoped>
@import "@/assets/scss/mainLayout.scss";
@import "@/assets/scss/animations.scss";
@import "@/assets/scss/variables.scss";
@import "@/assets/scss/utils.scss";

.colored-background {
  height: 100px;
  width: 50%;
  background-color: $main;
}

.out-clicker {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba($color: #000000, $alpha: 0.18);
  overflow: hidden;
  z-index: 9999999;
}

.followers-modal {
  z-index: 99999999;
  background: $white;
  position: fixed;
  max-height: 60vh;
  width: 70vw;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  border-radius: 10px;
  box-sizing: border-box;
  padding: 30px;
  box-shadow: 0 0 100px rgba($color: #000000, $alpha: 0.08);

  .header {
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-bottom: 20px;
    .close {
      cursor: pointer;
      display: flex;
      justify-content: center;
      align-items: center;
      svg {
        transform: rotate(-45deg);
        fill: $main;
      }
    }
  }

  .title {
    font-weight: bold;
    font-size: 1.4em;
    span {
      color: $main;
    }
  }

  .search-bar {
    width: 100%;
    height: 2.5em;
    box-shadow: 5px 5px 20px rgba($color: #000000, $alpha: 0.1);
    border-radius: 10px;
    overflow: hidden;
    margin-bottom: 20px;
    display: flex;
    flex-direction: row;
    align-items: center;
    input {
      width: 100%;
      color: $main;
      height: 100%;
      padding: 0 15px;
      outline: none;
      border: none;
    }

    span {
      margin-right: 15px;
      fill: $main;
      z-index: 2;
      width: 20px;
      height: 20px;
    }
  }

  ul {
    width: 100%;
    padding: 0;
    margin: 0;
    display: flex;
    flex-direction: column;
    height: 100%;
    overflow-y: auto;

    li {
      margin: 2px 0;
      display: flex;
      flex-direction: row;
      justify-content: flex-start;
      padding: 5px;
      transition: 0.3s;
      border-radius: 15px;
      cursor: pointer;
      &:hover,
      &:active {
        background: $gray;
      }
      .informations {
        margin-left: 10px;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        .username {
          font-weight: bold;
        }
        .profession {
          color: $main;
          font-weight: 400;
        }
      }
      .image-container {
        width: 50px;
        height: 50px;
        background-position: center;
        background-size: cover;
        border-radius: 12px;
      }
    }
  }
}

.content {
  margin-bottom: 80px;
  display: flex;
  flex-direction: column;
  .header {
    display: flex;
    flex-direction: row;
    align-items: center;
    .image-container {
      width: 40%;
      padding-top: 40%;
      background: $white;
      border-radius: 0 0 40px 0;
      background-position: center;
      background-size: cover;
    }
    .informations {
      width: 40%;
      margin-left: 30px;
      .username {
        font-size: 1.7em;
        font-weight: bold;
      }
      .profession {
        margin-top: 5px;
        font-size: 1em;
        font-weight: 400;
        color: $main;
      }
      .biography {
        margin-top: 20px;
        font-size: 0.8em;
      }
    }
  }

  .follow {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    color: $white;
    background: $main;
    width: 50%;
    padding: 10px 30px;
    border-radius: 0 10px 10px 0;
    cursor: pointer;
  }

  .follow.following {
    background: $green;
  }

  .counters {
    margin-top: 20px;
    display: flex;
    flex-direction: row;
    justify-content: center;
    .counter {
      cursor: pointer;
      display: flex;
      flex-direction: row;
      color: $main;
      justify-content: center;
      align-items: center;
      margin: 0 15px;
      .counter_icon {
        overflow: hidden;
        height: 20px;
        width: 20px;
        fill: $main;
      }
      p {
        margin-left: 5px;
      }
    }
  }

  .posts {
    margin-top: 20px;
    h1 {
      margin-left: 10px;
      span {
        color: $main;
      }
    }
    .posts-container {
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      padding: 0;
      list-style: none;
      width: calc(100vw - 5px);
      li {
        cursor: pointer;
        margin-left: 5px;
        margin-bottom: 5px;
        width: calc(100% / 3 - 5px);
        position: relative;
      }
      .hover {
        width: 100%;
        height: 100%;
        background-color: $black;
        border-radius: 5px;
        position: absolute;
        display: flex;
        flex-direction: column;
        top: 0;
        left: 0;
        opacity: 0;
        transition: 0.2s;
        color: white;
        align-items: center;
        justify-content: center;

        p {
          color: $white;
        }

        span {
          height: 30px;
          width: 30px;
          fill: $white;
          svg {
            width: 100%;
          }
        }
      }
      .image-container {
        width: 100%;
        padding-top: 100%;
        background-position: center;
        background-size: cover;
        border-radius: 5px;
        &:hover {
          .hover {
            opacity: 0.6;
          }
        }
      }
    }
  }
}
</style>