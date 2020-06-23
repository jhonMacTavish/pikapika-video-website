<template>
  <div id="banner" class="banner-box">
    <div class="user-wrap" @mouseleave="leave(user.username)">
      <router-link :to="{path:'/userinfo'}" target="_blank" tag="a" class="avatar">
        <img :src="user.avatar" alt @click="handleClick" />
      </router-link>
      <div class="button-wrap">
        <el-button v-if="!logged" class="button" type="text" @click="handleClick">登录</el-button>
        <router-link v-else :to="{path:'/userinfo'}" target="_blank" tag="a">
          <el-button type="text">
            <span
              ref="username"
              class="username"
              @mouseenter="enter(user.username)"
            >{{user.username}}</span>
          </el-button>
        </router-link>
        <!-- <el-button v-else class="button" type="text" @click="$router.push('/userinfo')">{{user.username}}</el-button> -->
        <el-button v-if="!logged" class="button" type="text" @click="register">注册</el-button>
        <el-button v-else class="button" type="text" @click="logout">注销</el-button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Banner",
  data() {
    return {
      user: {
        username: "",
        avatar: "../../../static/imgs/user/userAvatar.jpg"
      }
    };
  },
  computed: {
    logged() {
      return localStorage.token;
    }
  },
  created() {
    this.fetch();
    // : "../../../static/imgs/user/userAvatar.jpg";
  },
  mounted() {
    this.setNameWidth(true);
  },
  methods: {
    async fetch() {
      if (localStorage.token) {
        let res = await this.$http.get("/getUserinfo");
        this.user = res.data.user;
        this.user.avatar = this.user.avatar
          ? this.user.avatar
          : "../../../static/imgs/user/userAvatar.jpg";
        this.$store.commit('UpdateUser',this.user);
      }
    },
    handleClick() {
      if (!this.logged) {
        this.$router.push("/login");
      }
    },

    register() {
      this.$router.push("/register");
    },

    logout() {
      delete localStorage.token;
      location.reload(true);
    },

    enter(name) {
      this.setNameWidth(false);
    },

    leave(name) {
      // if (name.length <= 10) {
      this.setNameWidth(true);
      // }else{

      // }
      // this.$refs.username.style.width = "100px";
    },

    setNameWidth(init) {
      if (!this.user.username) return;
      let name = this.user.username;
      let length = init ? (name.length <= 10 ? name.length : 10) : name.length;
      let countW = 0;
      let countN = 0;
      for (let i = 0; i < length; i++) {
        if (name[i] === "W" || name[i] === "M") {
          countW++;
        } else if (name[i] === "i" || name[i] === "I") {
          countN++;
        }
      }
      this.$refs.username.style.width = `${(length - countW - countN) * 10 +
        countN * 4.5 +
        countW * 19}px`;
    }
  }
};
</script>

<style lang="less" scoped>
.banner-box {
  margin: 0 auto;
  position: relative;
  z-index: 0;
  min-height: 155px;
  // min-height: 180px;
  min-width: 1160px;
  background-color: #f9f9f9;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-pack: center;
  justify-content: center;
  background-repeat: no-repeat;
  background-position: center 20%;
  background-size: cover;
  background-image: url(../../../static/imgs/banner/banner.png);
  // background-image: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590062962660&di=b38e96aafd34ce829ee9900e79d0cbed&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F9825bc315c6034a8cd678f21cc1349540823768c.jpg);

  .user-wrap {
    // width: 100px;
    padding: 10px;
    height: 40px;
    position: absolute;
    top: 20px;
    right: 40px;
    border-radius: 10px;
    background: rgba(0, 0, 0, 0.2);
    img {
      height: 40px;
      width: 40px;
      border-radius: 50%;
      border: 1px solid rgba(0, 0, 0, 0.1);
    }

    img:hover {
      cursor: pointer;
    }

    .button-wrap {
      position: relative;
      margin-left: 10px;
      top: -13px;
      display: inline-block;

      .username {
        position: relative;
        top: 5px;
        display: inline-block;
        // width: 100px;
        height: 20px;
        text-align: center;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
        color: white !important;
        font-size: 18px;
        text-shadow: 0 1px 1px rgba(0, 0, 0, 1);
        transition: width 0.5s;
        border-radius: 2px;
        padding: 0 2px;
      }

      .username:hover {
        color: #39c5bb !important;
        background: rgba(255, 255, 255, 0.8);
        padding: 0 2px;
      }

      .button {
        color: white;
        font-size: 18px;
        text-shadow: 0 1px 1px rgba(0, 0, 0, 1);
      }

      .button:hover {
        color: #39c5bb;
      }
    }
  }
}
</style>