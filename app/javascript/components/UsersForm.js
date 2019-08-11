import PropTypes from 'prop-types'
import React from 'react'
import ReactDOM from 'react-dom'
import getGradeStr from './grade';

class UsersForm extends React.Component {
  constructor(props) {
    super(props);
    let users = props.default_users;
    let size = props.default_users.length;
    if (size == 0) {
      users.push({ grade: 0, name: "" });
    }
    this.state = {
      users: users,
    }
  }
  render() {
    console.log(this.props);
    return (<React.Fragment>{
      [...Array(this.state.users.length).keys()]
        .map(
          (id) => <
            UserForm ref={id} formid={id} onClick=
            {(ev) => this._onClickDel(ev, id)} default_grade=
            {this.state.users[id].grade} default_name=
            {this.state.users[id].name} key=
            {
              id
            } />)
    }
      <input type="button" onClick={this._onClickAdd.bind(this)} value="人数追加" />
    </React.Fragment>);
  }
  _onClickDel(ev, i) {
    let users = this.state.users.slice()
    console.log(users.splice(Number(i), 1));
    console.log(i);
    this.setState({ users: users });
  }
  _onClickAdd(ev) {
    let users = this.state.users.slice();
    users.push({ grade: 0, name: "" });
    this.setState({ users: users });
  }
}
UsersForm.defaultProps = { default_users: [] }

class UserForm extends React.Component{
  constructor(props) {
    super(props);
    this.state = {
      name: this.props.default_name,
      grade: this.props.default_grade,
    };
  }
  render() {
    return (
      <div>
        <h3>参加者{Number(this.props.formid)+1}</h3>
                <label>学年</label>
        <select value={this.state.grade}name={"entry[users][" + this.props.formid + "][grade]"}
          onChange={this._onGradeChange.bind(this)}>
          {[0, 1, 2, 3, 4, 5].map(
            (val) => <option value={val} key={val}>{getGradeStr(val)}</option>)}

            </select>
        <label>名前</label>
            <input type = 'text' value = {this.state.name} name =
                 {'entry[users][' + this.props.formid + '][name]'} onChange =
             {
               this._onNameChange.bind(this)
             } />
        {(this.props.button) ? <input type='button' value='ボタン' onClick={this.props.onClick} />:
                <p></p>}
      </div>);
  }
  _onNameChange(ev) {
    this.setState({
      name: ev.target.value
    });
    //console.log(this.state.name);
  }
  _onGradeChange(ev) {
    this.setState({
      grade: ev.target.value
    });
    //console.log(this.state.name);
  }
}
UserForm.defaultProps={formid:0,default_name:"",default_grade:0,button:true,onClick:null}
export default UsersForm
