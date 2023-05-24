import React, { useState } from "react";
import './AddAppointment.css';
import { Card, Box, InputLabel, InputBase, TextField, Button } from '@mui/material';
import { DatePicker } from '@mui/x-date-pickers/DatePicker';
import { AdapterDayjs } from '@mui/x-date-pickers/AdapterDayjs';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';
import HospitalHeader from "./header";
import { MobileTimePicker } from '@mui/x-date-pickers/MobileTimePicker';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select, { SelectChangeEvent } from '@mui/material/Select';
import { ScheduleAppointmentAPI } from "../services/userServices";


function AddAppointment() {

    const [appointmentObj, setAppointmentObj] = useState({date: null, startTime: null, endTime: null, disease:'', doctor:'', descripton: ''})

    const [selectedTime, setSelectedTime] = useState(null);

    const handleTimeChange = (e) => {
      setSelectedTime(e);
      takeStartTime()
    };

    const [selectedDate, setSelectedDate] = useState(null);

  const handleDateChange = (newDate) => {
    setSelectedDate(newDate);
    console.log('newDate',newDate)
  };

    //console.log(selectedTime)
    //console.log('selectedDate',selectedDate)
   

    const takeDate=(e)=>{
        setAppointmentObj(prevState=>({
            ...prevState,
            date: e.target.value
        }))
    }

    const takeDesc=(e)=>{
        setAppointmentObj(prevState=>({
            ...prevState,
            descripton: e.target.value
        }))
    }


    const takeEndTime=(e)=>{
        setAppointmentObj(prevState=>({
            ...prevState,
            endTime: e.target.value
        }))
    }

    const takeStartTime=()=>{
        setAppointmentObj(prevState=>({
            ...prevState,
            startTime: selectedTime
        }))
    }

    const takeDoctor=(e)=>{
        setAppointmentObj(prevState=>({
            ...prevState,
            doctor: e.target.value
        }))
    }

    const handleDisease=(e)=>{
        setAppointmentObj(prevState=>({
            ...prevState,
            disease: e.target.value
        }))
    }

    //console.log(appointmentObj)

    const SchNewAppointment = () => {
        ScheduleAppointmentAPI(appointmentObj)
        .then((response)=>{
            console.log(response)
        })
        .catch((error)=>{
            console.log(error)
        })
    }

    return (
        <Box sx={{ height: '100vh', width: '100vw' }}>
            <HospitalHeader />
            <Box className='appointmentPage'>
                <Box className='pageContent' >

                    <Card>
                        <Box className='appointmentContent'>
                            <Box sx={{ fontSize: 30 }}>Request an Appointment</Box>
                            <Box className='selectDate'>
                                <InputLabel className="labelTex" sx={{textAlign: 'left'}}>Select Date</InputLabel>
                                <FormControl fullWidth>

                                    <LocalizationProvider dateAdapter={AdapterDayjs}>
                                        <DatePicker disablePast 
                                        value={selectedDate}
                                        onChange={handleDateChange}
                                        dateFormat = 'dd/mm/yyyy'
                                        // filterDate={date=> date.getDay() != 6 && date.getDay() != 0}
                                        renderInput={(params) => <TextField {...params} />}
                                        />
                                    </LocalizationProvider>
                                </FormControl>
                            </Box>
                            <Box className='selectdisease'>
                                <InputLabel className="labelTex" sx={{textAlign: 'left'}}>Select Disease</InputLabel>
                                <FormControl fullWidth>
                                    
                                    <Select value={appointmentObj.disease} onChange={handleDisease}
                                        labelId="demo-simple-select-label"
                                        id="demo-simple-select"

                                    >
                                        <MenuItem value='Fever'>Fever</MenuItem>
                                        <MenuItem value='Cold'>Cold</MenuItem>
                                        <MenuItem value='Cough'>Cough</MenuItem>
                                    </Select>
                                </FormControl>
                            </Box>
                            <Box className='selectdisease'>
                                <InputLabel className="labelTex" sx={{textAlign: 'left'}}>Select Doctor</InputLabel>
                                <FormControl fullWidth>
                                    
                                    <Select value={appointmentObj.doctor} onChange={takeDoctor}
                                        labelId="demo-simple-select-label"
                                        id="demo-simple-select"
                                    >
                                        <MenuItem value='doctor1'>Doctor1</MenuItem>
                                        <MenuItem value='doctor2'>Doctor2</MenuItem>
                                        <MenuItem value='doctor3'>Doctor3</MenuItem>
                                    </Select>
                                </FormControl>
                            </Box>
                            <Box className='selectdisease'>
                                <InputLabel className="labelTex" sx={{textAlign: 'left'}}>Select visit Time</InputLabel>
                                <FormControl fullWidth>
                                    <LocalizationProvider dateAdapter={AdapterDayjs}>
                                        <MobileTimePicker 
                                        value={selectedTime}
                                        onChange={handleTimeChange}
                                        renderInput={(props) => <TextField {...props} />}/>
                                    </LocalizationProvider>
                                </FormControl>
                            </Box>
                            <Box className='selectdisease'>
                                <InputLabel className="labelTex" sx={{textAlign: 'left'}}>Select End Time</InputLabel>
                                <FormControl fullWidth>
                                    <LocalizationProvider dateAdapter={AdapterDayjs}>
                                        <MobileTimePicker 
                                        value={selectedTime}
                                        onChange={handleTimeChange}
                                        renderInput={(props) => <TextField {...props} />}/>
                                    </LocalizationProvider>
                                </FormControl>
                            </Box>

                            <Box className='selectdisease'>
                                <InputLabel className="labelTex" sx={{textAlign: 'left'}}>Other Description</InputLabel>
                                <FormControl fullWidth>
                                    <TextField onChange={takeDesc} id="outlined-basic" label="Description" variant="outlined" />
                                </FormControl>
                            </Box>
                            <Box className='appointmentButton'>
                                <Button onClick={SchNewAppointment} variant="contained">Request Appointment</Button>
                            </Box>

                        </Box>
                    </Card>
                </Box>
            </Box>
        </Box>

    )

}

export default AddAppointment
