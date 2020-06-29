<template>
  <div>
    <h1>{{announce_id?'编辑':'添加'}}公告</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="announce"
      label-width="200px"
      style="margin-right: 200px"
    >
      <el-form-item label="标题" prop="title">
        <el-input type="text" v-model="model.title" maxlength="20"></el-input>
      </el-form-item>
      <el-form-item label=告示内容 prop="content">
        <el-input type="textarea" v-model="model.content" maxlength="500" show-word-limit :rows="9"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click.native="submitForm('announce')">保 存</el-button>
        <el-button @click="$router.push('/announce/list')">取 消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "BangumiEdit",
  props: {
    announce_id: null
  },
  data() {
    let title = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入标题")); // 请输入番名
      } else {
        callback();
      }
    };

    let content = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入公示内容"));
      } else {
        callback();
      }
    };

    return {
      id:null,
      rules: {
        title: [{ validator: title, trigger: "blur" }],
        content: [{ validator: content, trigger: "blur" }]
      },

      model: {
        announce_id: 1,
        title: "",
        content: ""
      },
    };
  },
  computed: {
    types() {
      let types = this.$store.getters.types;
      types.length = 2;
      return types;
    }
  },
  watch: {},
  created() {
    this.id = this.announce_id;
    this.id && this.fetch();
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res;

          if (this.announce_id) {
            //console.log("更新");
            res = await this.$http.put(
              `/announces/${this.announce_id}`,
              params
            );
          } else {
            //console.log("创建");
            res = await this.$http.post("/announces", params);
          }

          //console.log("res***********", res);

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/announce/list");
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

    async fetch() {
      const res = await this.$http.get(`/announces/${this.announce_id}`);
      let list = res.data.list;
      if(list.length>0) this.model = res.data.list[0];
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
</style>
