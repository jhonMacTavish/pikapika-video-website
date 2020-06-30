<template>
  <div>
    <h1>轮播图列表</h1>
    <div>
      <el-button :disabled="carouselList.length>=5" type="text" @click="$router.push('/carousel/create')">
        <i class="el-icon-plus"></i>添加轮播图
      </el-button>
    </div>
    <el-table :data="carouselList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="imgSrc" label="图片" width="610px">
        <template slot-scope="scope">
          <img :src="scope.row.imgSrc" alt />
        </template>
      </el-table-column>
      <el-table-column prop="type_id" label="类型" width="60px">
        <template slot-scope="scope">
          <span>{{scope.row.type_id==1?"番剧":"国漫"}}</span>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="名称"></el-table-column>
      <el-table-column prop="episode" label="章节" width="100">
        <template slot-scope="scope">
          <span>{{`第 ${scope.row.episode} ${scope.row.type_id==1?'话':'集'}`}}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="130px">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/carousel/eidt/${scope.row.carousel_id}`)"
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
      carouselList: []
    };
  },
  async created() {},
  computed: {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/carousels");
      this.carouselList = res.data.list;
    },

    async remove(row) {
      this.$confirm(`是否确定要删除轮播图 "${row.name}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          const res = await this.$http.delete(`/carousels/${row.carousel_id}`);
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
  height: 166px;
  width: 580px;
  background: aquamarine;
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.1);
}
</style>
