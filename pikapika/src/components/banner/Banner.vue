<template>
  <div id="banner" class="banner-box">
    <div class="user-wrap">
      <span @click="$router.push('/userinfo')">
        <router-link :to="{path:'/userinfo'}" target="_blank" tag="a" class="avatar">
          <img :src="avtar" alt @click="handleClick" />
        </router-link>
      </span>
      <div class="button-wrap">
        <el-button v-if="!logged" class="button" type="text" @click="handleClick">登录</el-button>
        <router-link
          v-else
          :to="{path:'/userinfo'}"
          target="_blank"
          tag="a"
          class="usermame"
        >{{user.u_name}}</router-link>
        <!-- <el-button v-else class="button" type="text" @click="$router.push('/userinfo')">{{user.u_name}}</el-button> -->
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
      avtar: "",
      user: {}
    };
  },
  computed: {
    logged() {
      return JSON.parse(localStorage.getItem("pk_user_logged"));
    }
  },
  created() {
    // console.log("user", this.user);
    this.user = this.logged
      ? JSON.parse(localStorage.getItem("logged_user"))
      : {
          u_avatar: "../../../static/imgs/user/userAvatar.jpg"
        };
    this.avtar = this.user.u_avatar?this.user.u_avatar:"../../../static/imgs/user/userAvatar.jpg";
  },
  methods: {
    handleClick() {
      console.log("click");
      console.log("this.logged", this.logged);
      if (!this.logged) {
        this.$router.push("/login");
      }
    },

    register() {
      this.$router.push("/register");
    },

    logout() {
      // localStorage.removeItem("logged_user");
      // localStorage.removeItem("pk_user_logged");
      localStorage.clear();
      location.reload(true);
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
  min-width: 999px;
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
      .usermame {
        color: white !important;
        font-size: 18px;
        text-shadow: 0 1px 1px rgba(0, 0, 0, 1);
      }

      .usermame:hover {
        color: #f25d8e !important;
      }

      .button {
        color: white;
        font-size: 18px;
        text-shadow: 0 1px 1px rgba(0, 0, 0, 1);
      }

      .button:hover {
        color: #f25d8e;
      }
    }
  }
}
</style>