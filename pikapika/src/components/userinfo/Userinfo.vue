<template>
  <div>
    <div class="banner"></div>
    <div class="backgound">
      <div class="userinfo-box">
        <el-card class="box-card">
          <el-tabs v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="我的信息" name="first">
              <el-form
                :model="model"
                :rules="rules"
                ref="userinfo"
                label-width="200px"
                @submit.native.prevent="save"
                style="margin-right: 200px"
              >
                <el-form-item label="用户名：" prop="u_name">
                  <el-input v-model="model.u_name" style="width:222px" maxlength="48"></el-input>
                </el-form-item>

                <el-form-item label="邮箱：" prop="u_email">
                  <span>{{model.u_email}}</span>
                </el-form-item>
                <el-form-item label="性别：" prop="u_sex">
                  <template>
                    <el-radio-group v-model="model.u_sex">
                      <el-radio :label="0">男</el-radio>
                      <el-radio :label="1">女</el-radio>
                    </el-radio-group>
                  </template>
                </el-form-item>

                <el-form-item label="头像：" prop="u_avatar">
                  <img class="avatar" :src="model.u_avatar" />
                </el-form-item>

                <el-form-item label="头像地址：" prop="u_avatar">
                  <el-input v-model="model.u_avatar"></el-input>
                </el-form-item>

                <el-form-item label="创建时间：" prop="create_time">
                  <span>{{model.create_time}}</span>
                </el-form-item>
              </el-form>
              <div class="button-wrap">
                <el-button class="button" type="primary" @click.native="submitForm('userinfo')">保 存</el-button>
              </div>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "Userinfo",
  data() {
    let u_name = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入用户名")); // 请输入番名
      } else {
        callback();
      }
    };

    let u_password = (rule, value, callback) => {
      let reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
      if (!value) {
        callback(new Error("请输入密码")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("密码由字母数字下划线组成的6-16位字符串"));
      }
    };

    let u_avatar = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      activeName: "first",
      rules: {
        u_name: [{ validator: u_name, trigger: "blur" }],
        u_password: [{ validator: u_password, trigger: "blur" }]
      },

      model: {
        u_name: "",
        u_email: "",
        u_password: "",
        u_sex: 0,
        u_avatar: "",
        create_time: ""
      }
    };
  },
  computed: {},
  watch: {},
  created() {
    this.fetch();
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          console.log("save");

          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res = await this.$http.put(`/userinfos`, params);

          console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
          } else {
            this.$message({
              type: "error",
              message: res.data.msg
            });
          }
        } else {
          this.$message({
            type: "error",
            message: "请将表格填写完整"
          });
          return false;
        }
      });
    },

    async save() {
      console.log("save");
      var objString = JSON.stringify(this.model);
      var params = JSON.parse(objString);

      console.log("params*************", params);
      const res = await this.$http.post("/userinfos", params);
      console.log("res***********", res);

      if (res.affectedRows === 1) {
        this.$message({
          type: "success",
          message: res.msg
        });
        this.$router.push("/userinfo/list");
      } else {
        this.$message({
          type: "error",
          message: res.msg
        });
      }
    },

    async fetch() {
      console.log("edit");
      const res = await this.$http.post(`/userinfos`);

      this.model = res.data.user;
      console.log("this.model", this.model);
    },
    handleClick() {}
  },
  components: {}
};
</script>

<style lang='less' scoped>
.banner {
  position: relative;
  width: 100%;
  height: 200px;
  // background: url(http://tva2.sinaimg.cn/large/006AYjs4ly1g7axntaeu7j31uo0cetk3.jpg);
  background-image: url(../../../static/imgs/banner/banner2.png);
  // background-image: url(https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590062962660&di=b38e96aafd34ce829ee9900e79d0cbed&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F-Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2F9825bc315c6034a8cd678f21cc1349540823768c.jpg);
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  overflow: hidden;
}

.backgound {
  width: 100%;
  .userinfo-box {
    width: 1160px;
    margin: 0 auto;
    margin-top: 40px;
    .avatar {
      display: inline-block;
      width: 74px;
      height: 73px;
      overflow: hidden;
      border: 1px solid rgba(0, 0, 0, 0.1);
      border-radius: 5px;
    }

    .button-wrap {
      margin: 0 auto;
      width: 100px;
      .button {
        width: 100px;
      }
    }
  }
}
</style>
