<template>
  <div>
    <h1>公告列表</h1>
    <div>
      <el-button
        :disabled="announceList.length>=5"
        type="text"
        @click="$router.push('/announce/create')"
      >
        <i class="el-icon-plus"></i>添加公告
      </el-button>
    </div>
    <el-table :data="announceList" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="title" label="标题" width="200">
        <template slot-scope="scope">
          <p :title="scope.row.title" class="content">{{scope.row.title}}</p>
        </template>
      </el-table-column>
      <el-table-column prop="content" label="内容">
        <template slot-scope="scope">
          <p :title="scope.row.content" class="content">{{scope.row.content}}</p>
        </template>
      </el-table-column>
      <el-table-column prop="create_time" label="发布时间" width="200">
        <template slot-scope="scope">
          <span>{{scope.row.create_time.replace(/T|.000Z/g," ")}}</span>
        </template>
      </el-table-column>
      <el-table-column prop="adminname" label="发布人" width="160"></el-table-column>
      <el-table-column label="操作" width="130px">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/announce/eidt/${scope.row.announce_id}`)"
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
      announceList: []
    };
  },
  async created() {},
  computed: {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/announces");
      this.announceList = res.data.list;
    },

    async remove(row) {
      this.$confirm(`是否确定要删除公告 "${row.title}"`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(async () => {
          const res = await this.$http.delete(`/announces/${row.announce_id}`);
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

.content {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
