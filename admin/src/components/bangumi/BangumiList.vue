<template>
  <div>
    <h1>番剧列表</h1>
    <el-table :data="items" stripe>
      <el-table-column type="index" width="50"></el-table-column>
      <el-table-column prop="b_name" label="名称"></el-table-column>
      <el-table-column prop="b_episodes" label="集数"></el-table-column>
      <el-table-column prop="b_style" label="风格"></el-table-column>
      <el-table-column prop="b_playtime" label="上映时间"></el-table-column>
      <el-table-column
        fixed="right"
        label="操作"
        width="180">
        <template slot-scope="scope">
            <el-button type="text" size="small">查看</el-button>
            <el-button type="text" size="small" @click="$router.push(`/bangumi/eidt/${scope.row.v_id}`)">编辑</el-button>
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
      items: []
    };
  },
  created() {
    this.fetch();
  },
  computed: {},
  watch: {},
  methods: {
    async fetch() {
      const res = await this.$http.get("/bangumis");
      this.items = res.data.list;
      console.log("res", res);
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
</style>
