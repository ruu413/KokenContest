import {transcode} from 'buffer';
import PropTypes from 'prop-types'
import React from 'react'
import ReactDOM from 'react-dom'

import getGradeStr from './grade';
import getTypeStr from './type';



class EditOrderTable extends React.Component {
  constructor(props) {
    super(props);
    //console.log(props);
    this.req = new XMLHttpRequest();
    this.req.onreadystatechange = this._getJson.bind(this);
    this.req.open('GET', '/entries.json', true);
    this.req.send(null);
    this.state = {
      entries: []  // props.default_entries,
    };
  }
  _getJson() {
    if (this.req.readyState == 4) {  // 通信の完了時
      if (this.req.status == 200) {  // 通信の成功時
        let entries = JSON.parse(this.req.responseText);
        entries.sort((a, b) => {
          return a.id - b.id
        })
        this.setState({ entries: entries });
        //console.log(JSON.parse(this.req.responseText));
      }
    } else {
    }
  }
  _onChangeForm(i,ev) {
    let entry = this.state.entries.slice();
    entry[i].order = ev.target.value;
    this.setState({ entry: entry });
  }

  render() {
    return (<React.Fragment><table><tbody>
      <tr>
      <th>発表順</th>
      <th>部門</th>
      <th>チーム名</th>
      <th>学年</th>
      <th>名前</th>
      <th>作品名</th>  
      <th>説明</th>
      <th></th>
      <th></th>
      <th></th></tr>
      {this.state.entries.map((entry,i) => {
        return <EntryTr onChangeOrder={(ev) => { this._onChangeForm(i, ev) }} entry={entry} key={entry.id}></EntryTr>;
    })
  }
    </tbody></table>
        {/*<select>
      <option value = {1}>エントリー順</option>
      <option value = {0}>発表順</option>
    </select>*/}
    </React.Fragment>)
  }
  /*_onChangeSort(ev) {
    let entries = this.state.entries.slice();
   
    if (ev.target.value == 0) {
       entries.sort((a,b) => {
        return a.order < b.order
      })
    } else {
       entries.sort((a,b) => {
        return a.id < b.id
      })
    }
  }*/
}
class EntryTr extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    //console.log(this.props)
    const span=this.props.entry.users.length
    let users_1toE = this.props.entry.users.slice()
    users_1toE.shift()
    //console.log(users_1toE)
    return (
      <React.Fragment>
        <tr>
          <td rowSpan={span}>
            <input type="hidden" name={"entries[" + this.props.entry.id + "][id]"} value={this.props.entry.id}/>
            <input onChange={this.props.onChangeOrder} type='number' value={this.props.entry.order} name={'entries['+this.props.entry.id+'][order]'}/>
          </td>
          <td rowSpan={span}>
            {getTypeStr(this.props.entry.type)}
          </td>
          <td rowSpan={span}>
            {this.props.entry.teamname}
          </td>
          <td>
            {getGradeStr(this.props.entry.users[0].grade)}
          </td>
          <td>
            {this.props.entry.users[0].name}
          </td>
          <td rowSpan={span}>
            {this.props.entry.prodname}
          </td>
          <td rowSpan={span}>
            {this.props.entry.description}
          </td>
          
            
          <td><a href={'/entries/'+this.props.entry.id}>詳細</a></td>
          <td><a href={'/entries/'+this.props.entry.id+'/edit'}>編集</a></td>
          <td><a data-confirm='Are you sure?' rel='nofollow' data-method='delete' href={'/entries/'+this.props.entry.id}>削除</a></td>
          
        </tr>
        {users_1toE.map(
          (user) => <tr key= {user.id}>
            <td>{getGradeStr(user.grade)}</td>
            <td>{user.name}</td>
          </tr>)
  }
      </React.Fragment>
      );
  }
}

export default EditOrderTable
