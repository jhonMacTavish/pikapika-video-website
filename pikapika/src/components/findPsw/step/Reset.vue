<template>
  <div class="reset-box">
    <div class="register-container">
      <div class="form-wrap">
        <el-form
          :model="resetForm"
          ref="resetForm"
          label-position="left"
          label-width="70px"
          class="form"
        >
          <el-form-item label="密码" prop="psw">
            <el-input type="password" placeholder="新密码" v-model="resetForm.psw"></el-input>
          </el-form-item>
          <el-form-item label="确认密码" prop="confirmPsw">
            <el-input type="password" placeholder="确认密码" v-model="resetForm.confirmPsw"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <p>{{account}}</p>
          </el-form-item>
          <el-form-item label="验证码" prop="captcha" class="captcha-wrap">
            <el-input placeholder="验证码" v-model="resetForm.captcha" maxlength="4" class="captcha"></el-input>
            <el-button type="primary" class="captcha-button">获取验证码</el-button>
          </el-form-item>
          <el-button type="primary" class="register-buttom" @click="$router.push({name:'success'})">确认修改</el-button>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Reset",
  data() {
    return {
      resetForm: {
        account: "981192661@qq.com",
        psw: "",
        confirmPsw: "",
        captcha: ""
      }
    };
  },
  computed: {
    account(){
      let email = this.resetForm.account;
      return email;
    }
  },
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.register-container {
  position: relative;
  width: 100%;
  margin: 0 auto;
  // padding: 60px 0;
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

      .register-buttom {
        width: 100%;
      }

      .login-tip {
        position: relative;
        margin-top: 10px;
        width: 100%;
        span {
          position: absolute;
          right: 0;
          font-size: 13px;
          color: #00a1d6;
          cursor: pointer;
        }
      }
    }
  }
}
.register-container::after {
  content: "";
  display: block;
  clear: both;
  visibility: hidden;
}
</style>
