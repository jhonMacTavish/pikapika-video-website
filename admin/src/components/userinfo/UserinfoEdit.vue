<template>
  <div>
    <h1>{{id?'编辑':'添加'}}用户</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="userinfo"
      label-width="200px"
      @submit.native.prevent="save"
      style="margin-right: 200px"
    >
      <el-form-item label="名称" prop="username">
        <el-input v-model="model.username" style="width:222px" maxlength="48"></el-input>
      </el-form-item>

      <el-form-item label="邮箱" prop="email">
        <el-input v-model="model.email" style="width:222px" maxlength="100"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input type="password" v-model="model.password" style="width:222px" maxlength="16"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="is_man">
        <template>
          <el-radio-group v-model="model.is_man">
            <el-radio :label="0">男</el-radio>
            <el-radio :label="1">女</el-radio>
          </el-radio-group>
        </template>
      </el-form-item>

      <el-form-item label="头像地址" prop="avatar">
        <el-input v-model="model.avatar" maxlength="500"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click.native="submitForm('userinfo')">保 存</el-button>
        <el-button @click="$router.push('/userinfo/list')">取 消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "BangumiEdit",
  props: {
    id: {}
  },
  data() {
    let username = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入番名")); // 请输入番名
      } else {
        callback();
      }
    };

    let email = (rule, value, callback) => {
      let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
      if (!value) {
        callback(new Error("请输入邮箱")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("请输入正确的邮箱格式"));
      }
    };

    let password = (rule, value, callback) => {
      let reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
      if (!value) {
        callback(new Error("请输入密码")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("密码由字母数字下划线组成的6-16位字符串"));
      }
    };

    let avatar = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        username: [{ validator: username, trigger: "blur" }],
        email: [{ validator: email, trigger: "blur" }],
        password: [{ validator: password, trigger: "blur" }],
      },

      model: {
        username: "",
        email: "",
        password: "",
        is_man: 0,
        avatar: ""
      },

      styleVisible: false,
      styleValue: "",

      actorsVisible: false,
      actorsValue: ""
    };
  },
  computed: {},
  watch: {},
  created() {
    this.id && this.fetch();
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          //console.log("save");

          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res;

          if (this.id) {
            //console.log("更新");
            res = await this.$http.put(`/userinfos/${this.id}`, params);
          } else {
            //console.log("创建");
            res = await this.$http.post("/userinfos", params);
          }

          //console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/userinfo/list");
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
      //console.log("save");
      var objString = JSON.stringify(this.model);
      var params = JSON.parse(objString);

      //console.log("params*************", params);
      const res = await this.$http.post("/userinfos", params);
      //console.log("res***********", res);

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
      //console.log("edit");
      const res = await this.$http.post(`/userinfos/${this.id}`);

      res.data[0]?this.model = res.data[0]:'';
      //console.log("this.model", this.model);
    },
  },
  components: {}
};
</script>

<style lang='less' scoped>
.el-tag {
  margin-right: 10px;
}
.button-new-tag {
  // margin-left: 10px;
  height: 32px;
  line-height: 30px;
  padding-top: 0;
  padding-bottom: 0;
}
.input-new-tag {
  position: relative;
  bottom: -1px;
  width: 90px;
  // margin-left: 10px;
  vertical-align: bottom;
}
</style>
