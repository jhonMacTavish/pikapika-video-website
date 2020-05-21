<template>
  <div>
    <h1>{{id?'编辑':'添加'}}管理员</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="adminusers"
      label-width="200px"
      @submit.native.prevent="save"
      style="margin-right: 200px"
      class="adminusers"
    >
      <el-form-item label="姓名" prop="a_name">
        <el-input v-model="model.a_name" style="width:222px" maxlength="48"></el-input>
      </el-form-item>

      <el-form-item label="邮箱" prop="a_email">
        <el-input v-model="model.a_email" style="width:222px" maxlength="100"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="a_password">
        <el-input type="password" v-model="model.a_password" style="width:222px" maxlength="16"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click.native="submitForm('adminusers')">保 存</el-button>
        <el-button @click="$router.push('/adminuser/list')">取 消</el-button>
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
    let a_name = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入管理员姓名")); // 请输入番名
      } else {
        callback();
      }
    };

    let a_email = (rule, value, callback) => {
      let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
      if (!value) {
        callback(new Error("请输入邮箱")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("请输入正确的邮箱格式"));
      }
    };

    let a_password = (rule, value, callback) => {
      let reg = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$/;
      if (!value && this.id) {
        callback(); // 请输入请输入集数
      } else if (!value && !this.id) {
        callback(new Error("请输入密码")); // 请输入请输入集数
      } else if (reg.test(value)) {
        callback();
      } else {
        callback(new Error("密码由字母数字下划线组成的6-16位字符串"));
      }
    };

    return {
      rules: {
        a_name: [{ validator: a_name, trigger: "blur" }],
        a_email: [{ validator: a_email, trigger: "blur" }],
        a_password: [{ validator: a_password, trigger: "blur" }]
      },

      model: {
        a_name: "",
        a_email: "",
        a_password: ""
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
    this.id && this.featch();
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          console.log("save");

          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res;

          if (this.id) {
            console.log("更新");
            res = await this.$http.put(`/adminusers/${this.id}`, params);
          } else {
            console.log("创建");
            res = await this.$http.post("/adminusers", params);
          }

          console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/adminuser/list");
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
      const res = await this.$http.post("/adminusers", params);
      console.log("res***********", res);

      if (res.affectedRows === 1) {
        this.$message({
          type: "success",
          message: res.msg
        });
        this.$router.push("/adminusers/list");
      } else {
        this.$message({
          type: "error",
          message: res.msg
        });
      }
    },

    async featch() {
      console.log("edit");
      const res = await this.$http.post(`/adminusers/${this.id}`);

      this.model = res.data[0];
      console.log("this.model", this.model);
    },

    styHandleClose(tag) {
      this.model.a_style.splice(this.model.a_style.indexOf(tag), 1);
    },

    styShowInput() {
      this.styleVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveStyleInput.$refs.input.focus();
      });
    },

    styHandleInputConfirm() {
      let styleValue = this.styleValue;
      if (styleValue) {
        this.model.a_style.push(styleValue);
      }

      this.styleVisible = false;
      this.styleValue = "";
    },

    actHandleClose(tag) {
      this.model.a_actors.splice(this.model.a_actors.indexOf(tag), 1);
    },

    actShowInput() {
      this.actorsVisible = true;
      this.$nextTick(_ => {
        this.$refs.saveActorInput.$refs.input.focus();
      });
    },

    actHandleInputConfirm() {
      let actorsValue = this.actorsValue;
      if (actorsValue) {
        this.model.a_actors.push(actorsValue);
      }
      this.actorsVisible = false;
      this.actorsValue = "";
    }
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

.adminusers {
  margin-top: 40px;
}
</style>
