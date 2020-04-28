<template>
  <div class="login-page">
    <div class="banner">
      <div class="banner-button-wrap">
        <el-button size="small" class="banner-button" @click="$router.push({name:'home'})">返回首页</el-button>
      </div>
    </div>
    <div class="title-line">
      <span class="tit">登录</span>
    </div>
    <div class="login-container">
      <div class="login-img-wrap">
        <div class="img-container">
          <div class="img-left"></div>
          <div class="img-right"></div>
        </div>
      </div>
      <div class="form-wrap">
        <el-form
          :model="userForm"
          :rules="rules"
          ref="userForm"
          label-position="left"
          label-width="70px"
          class="form"
        >
          <el-form-item label="账号" prop="account">
            <el-input type="text" placeholder="账号" v-model="userForm.account"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="psw">
            <el-input type="password" placeholder="密码" v-model="userForm.psw"></el-input>
          </el-form-item>

          <el-form-item label="验证码" prop="captcha" class="captcha-wrap">
            <el-input placeholder="验证码" v-model="userForm.captcha" maxlength="4" class="captcha"></el-input>
            <el-button type="primary" class="captcha-button">获取验证码</el-button>
          </el-form-item>
          <div class="item-wrap">
            <el-checkbox v-model="checked" class="remember">
              <span>记住我</span>
              <span>不是自己的电脑上不要勾选此项</span>
            </el-checkbox>
            <router-link to="register/findpassword" class="forget-psw">忘记密码</router-link>
          </div>
          <div class="button-wrap">
            <el-button type="primary" class="login-button" @click="login">登录</el-button>
            <el-button type="primary" class="register-button" @click="register">注册</el-button>
          </div>
        </el-form>
      </div>
    </div>
    <Footer />
  </div>
</template>

<script>
import Footer from "@/components/footer/Footer";

export default {
  name: "LoginPage",
  data() {
    let validateAccount = (rule, value, callback) => {
      let reg = /\w+((-w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+/;
      if (!value) {
        callback(new Error("请输入邮箱")); // 请输入绑定邮箱
      } else if (!reg.test(value)) {
        callback(new Error("请输入正确的邮箱地址格式")); // 请输入正确的邮箱地址格式
      } else {
        callback();
      }
    };

    let validatePsw = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入密码")); // 请输入密码
      } else {
        callback();
      }
    };

    let captcha = (rule, value, callback) => {
      console.log(Number(value));
      if (value === "") {
        callback(new Error("请输入验证码"));
      } else if (isNaN(Number(value)) || value.length < 4) {
        callback(new Error("请输入4位数值"));
      } else {
        callback();
      }
    };

    return {
      checked: false,
      userForm: {
        account: "",
        psw: "",
        captcha: ""
      },
      rules: {
        account: [{ validator: validateAccount, trigger: "blur" }],
        psw: [{ validator: validatePsw, trigger: "change" }],
        captcha: [{ validator: captcha, trigger: "blur" }]
      }
    };
  },
  computed: {},
  watch: {
    checked(val, oldVal) {}
  },
  methods: {
    login(){
      console.log("login", )
      // this.$router.push({path: '/login'})
    },

    register(){
      this.$router.push({path: '/register'})
    }
  },
  components: { Footer }
};
</script>

<style lang='less' scoped>
.login-page {
  width: 100%;
  .banner {
    position: relative;
    width: 100%;
    height: 282px;
    background: url(http://tva2.sinaimg.cn/large/006AYjs4ly1g7axntaeu7j31uo0cetk3.jpg);
    background-position: center;
    background-size: cover;
    overflow: hidden;
    .banner-button-wrap{
      position: absolute;
      top: 20px;
      right: 180px;
      // width: 80px;
      .banner-button{
        // color: #00A1D6;
        border: none;
        background: #FB7299;
      }

      .banner-button:hover{
        color: white;
      }
    }
  }

  .title-line {
    margin: 0 auto;
    margin-top: 30px;
    margin-bottom: 29px;
    width: 980px;
    height: 28px;
    text-align: center;
    border-bottom: 1px solid #dddddd;
    .tit {
      height: 57px;
      line-height: 57px;
      padding: 0 20px;
      font-size: 38px;
      background: white;
    }
  }

  .login-container {
    position: relative;
    width: 980px;
    margin: 0 auto;
    padding: 60px 0;
    .form-wrap {
      width: 420px;
      margin: 0 auto;
      // margin-top: 40px;
      // .item-width {
      //   width: 100%;
      // }

      .form {
        position: relative;
        .el-form-item {
          position: relative;
        }

        .captcha-wrap {
          .captcha {
            width: 60%;
          }

          .captcha-button {
            float: right;
            width: 36%;
          }
        }

        .captcha-wrap::after {
          content: "";
          display: block;
          clear: both;
          visibility: hidden;
        }

        .item-wrap {
          position: relative;
          margin-bottom: 10px;
          width: 100%;
          height: 20px;
          font-size: 13px;
          .remember {
            position: absolute;
            left: 0;
            span {
          font-size: 13px;
              color: #bbbbbb;
            }

            span:nth-child(0n + 1) {
              margin-right: 8px;
              color: black;
            }
          }

          .forget-psw {
            position: absolute;
            right: 0;
            color: #00a1d6;
          }
        }

        .button-wrap {
          width: 100%;
          position: relative;
          .login-button {
            position: absolute;
            width: 45%;
            left: 0;
          }

          .register-button {
            position: absolute;
            width: 45%;
            right: 0;
          }
        }
      }
    }

    .login-img-wrap {
      position: absolute;
      width: 100%;
      height: 200px;
      .img-container {
        position: relative;
        div {
          width: 160px;
          height: 260px;
          position: absolute;
          background: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1587663294881&di=62ad5010951a728190388c6dcdcf15b2&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farticle%2F4c3cfc538f94d015b72bf57c8f71dca723c4f976.jpg);
          // background-color: bisque;
          background-repeat: no-repeat;
          background-size: cover;
        }

        .img-left {
          left: 0;
          background-position: -46px 0;
        }

        .img-right {
          background-position: -236px 0;
          right: 0;
        }
      }
    }
  }

  .login-container::after {
    content: "";
    display: block;
    clear: both;
    visibility: hidden;
  }
}
</style>
