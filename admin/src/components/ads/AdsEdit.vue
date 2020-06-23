<template>
  <div>
    <h1>{{ad_id?'编辑':'添加'}}广告</h1>
    <el-form
      :model="model"
      :rules="rules"
      ref="ads"
      label-width="200px"
      style="margin-right: 200px"
    >
      <el-form-item label="商标" prop="brand">
        <el-input
          type="text"
          v-model="model.brand"
          style="width:222px"
          maxlength="16"
        ></el-input>
      </el-form-item>
      <el-form-item label="链接" prop="url">
        <el-input
          type="text"
          v-model="model.url"
          maxlength="100"
        >
        </el-input>
      </el-form-item>
      <el-form-item label="图片地址" prop="imgSrc">
        <el-input v-model="model.imgSrc" maxlength="500"></el-input>
      </el-form-item>
      <el-form-item label="图片">
        <img :src="model.imgSrc" alt="">
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click.native="submitForm('ads')">保 存</el-button>
        <el-button @click="$router.push('/ads/list')">取 消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "BangumiEdit",
  props: {
    ad_id: null
  },
  data() {
    let brand = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入商标")); // 请输入番名
      } else {
        callback();
      }
    };

    let url = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请输入链接"));
      } else {
        callback();
      }
    };

    let imgSrc = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请添加图片路径")); // 请输入请输入集数
      } else {
        callback();
      }
    };

    return {
      rules: {
        brand: [{ validator: brand, trigger: "blur" }],
        url: [{ validator: url, trigger: "blur" }],
        imgSrc: [{ validator: imgSrc, trigger: "blur" }]
      },

      filmNames: [],

      model: {
        brand: 1,
        url: null,
        imgSrc: ""
      },
    };
  },
  computed: {},
  watch: {},
  created() {
    this.ad_id && this.fetch();
  },
  methods: {

    submitForm(formName) {
      this.$refs[formName].validate(async valid => {
        if (valid) {
          var objString = JSON.stringify(this.model);
          var params = JSON.parse(objString);

          let res;

          if (this.ad_id) {
            //console.log("更新");
            params.ad_id = this.ad_id;
            res = await this.$http.put(`/ads/${this.ad_id}`, params);
          } else {
            //console.log("创建");
            res = await this.$http.post("/ads", params);
          }

          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.$router.push("/ads/list");
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
      //console.log("this.ad_id", this.ad_id);
      const res = await this.$http.get(`/ads/${this.ad_id}`);
      res.data[0]?this.model = res.data[0]:'';
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

img{
  display: inline-block;
  width: 100%;
  height: 74px;
  border-radius: 5px;
  background: aquamarine;
}
</style>
