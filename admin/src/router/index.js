import Vue from 'vue'
import Router from 'vue-router'
import Main from '@/components/main/Main'
import BangumiEdit from '@/components/bangumi/BangumiEdit'
import BangumiList from '@/components/bangumi/BangumiList'
import Test from '@/components/test'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'main',
      component: Main,
      children:[
        {path:'/bangumi/create',component: BangumiEdit},
        {path:'/bangumi/eidt/:id',component: BangumiEdit,props:true},
        {path:'/bangumi/list',component: BangumiList}
      ]
    },
    {
      path:'/test',
      component: Test
    }
  ]
})
