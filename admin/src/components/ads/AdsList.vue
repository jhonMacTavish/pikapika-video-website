<template>
  <div>
    <h1>广告列表</h1>
    <div>
      <el-button :disabled="adsList.length>=3" type="text" @click="$router.push('/ads/create')">
        <i class="el-icon-plus"></i>添加广告
      </el-button>
    </div>
    <el-table :data="adsList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="imgSrc" label="图片">
        <template slot-scope="scope">
          <img :src="scope.row.imgSrc" alt />
        </template>
      </el-table-column>
      <el-table-column prop="brand" label="商标" width="120">
      </el-table-column>
      <el-table-column prop="url" label="链接" width="380">
        <template slot-scope="scope">
          <a :href="scope.row.url" target="_black">{{scope.row.url}}</a>
        </template>
      </el-table-column>
      
      <el-table-column label="操作" width="180">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/ads/eidt/${scope.row.ad_id}`)"
            class="edit"
          >编辑</el-button>
          <el-button type="text" size="small" @click="remove(scope.row)" class="delete">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  name: "BangumiList",
  data() {
    return {
      adsList: []
    };
  },
  async created() {},
  computed: {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/ads");
      this.adsList = res.data.list;
    },

    async remove(row) {
      this.$confirm(`是否确定要删除广告 "${row.brand}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          const res = await this.$http.delete(`/ads/${row.ad_id}`);
          if (res.data.status == 200) {
            this.$message({
              type: "success",
              message: res.data.msg
            });
            this.fetch();
          } else {
            this.$message({
              type: "error",
              message: res.data.msg
            });
          }
        })
        .catch(() => {
          return;
        });
    }
  },
  components: {},
  beforeRouteEnter(to, from, next) {
    next(async vm => {
      await vm.fetch();
    });
  }
};
</script>

<style lang='less' scoped>
.edit {
  color: #67c23a;
}

.delete {
  color: #f56c6c;
}

img {
  display: inline-block;
  width: 100%;
  height: 48px;
  border-radius: 5px;
  background: aquamarine;
  border: 1px solid rgba(0, 0, 0, 0.1);
}
</style>
